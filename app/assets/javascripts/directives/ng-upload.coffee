angular.module('directive.ng-upload', [])
.directive "ngUpload", ['Upload', 'Restangular'
  (Upload, Restangular)->
    restrict: "E"
    scope:
      ngModel: "="
      parent: "="
      multiple: "="
    templateUrl: (elem,attrs) ->
      if _.isUndefined(attrs.dropzone)
        "directives/ngUpload.html"
      else
        "directives/dropzone.html"
    link: (scope, element, attrs) ->
      scope.tags = [] unless scope.tags
      scope.button = attrs.button
      scope.accept = attrs.accept
      scope.icon = attrs.icon

      capitalize = (string) ->
        string.charAt(0).toUpperCase() + string.slice(1)
      sourceType = (type) ->
        switch type
          when 'photo' then 'Photo'
          when 'audio' then 'AudioSource'
      pluralize = (string) ->
        string.toLowerCase()+'s'

      modelName = ->
        name = attrs.ngModel
        if name.lastIndexOf(".") > 0
          idx = name.lastIndexOf(".")
          name = name.substr(idx + 1)
        return name
      parentName = ->
        attrs.parent
      collection = ->
        scope.parent[pluralize(modelName())] ?= []

      folderParent = ->
        if scope.parent then parentName() else modelName()
      folderName = ->
        if scope.parent then pluralize(modelName()) else attrs.attribute
      folderId = ->
        if scope.parent then scope.parent.id else scope.ngModel.id
      folderUrl = ->
        "#{folderParent()}/#{folderName()}/#{folderId()}"
      uploadPreset = ->
        if !attrs.accept || attrs.accept.indexOf("image") > -1
          $.cloudinary.config().image_preset
        else if attrs.accept.indexOf("audio") > -1
          $.cloudinary.config().audio_preset
        else
          $.cloudinary.config().file_preset
      needDeleteTag = ->
        if scope.parent && scope.parent.id
          return false
        else
          return true

      # observe file upload
      scope.$watch 'files', ->
        return if !scope.files
        scope.tags = "#{attrs.tags}, delete" if needDeleteTag()
        countExistUploads = collection().length if scope.parent
        if scope.parent && scope.multiple
          _.times scope.files.length, (n)->
            scope.ngModel = {}
            collection().push scope.ngModel
          for file, idx in scope.files
            model = collection()[countExistUploads+idx]
            model["#{attrs.attribute}_preview"] = file
            upload(file, model)
        else
          collection().push scope.ngModel if scope.parent
          scope.ngModel["#{attrs.attribute}_preview"] = scope.files
          upload(scope.files)

      upload = (file, model) ->
        Upload.upload(
          url: "https://api.cloudinary.com/v1_1/" + $.cloudinary.config().cloud_name + "/upload",
          fields: {
            upload_preset: uploadPreset(),
            tags: scope.tags,
            folder: folderUrl()
          },
          file: file,
        ).progress( (e) ->
          updateUploadingStatus(e, model)
          percentage = Math.round((e.loaded * 100.0) / e.total)
          updateUploadingStatus(percentage, model)
          scope.button = "Uploading..#{percentage}%" unless scope.multiple
        ).success( (data, status, headers, config) ->
          scope.button = attrs.button
          updateUploadingStatus(undefined, model)
          updateNgModel(data)
#          if scope.parent then updateParent(data, model) else updateNgModel(data)
        ).error( (error) ->
          scope.button = attrs.button
          scope.parent[pluralize(modelName())] = _.without(collection(), scope.ngModel) if scope.parent
          ngToast.create
            content: error.error.message
            dismissButton: true
            verticalPosition:'bottom'
            class: 'danger'
        )

      updateUploadingStatus = (status, model) ->
        if model
          model["#{attrs.attribute}_uploading_process"] = status
        else
          scope.ngModel["#{attrs.attribute}_uploading_process"] = status

      uploadToServer = (upload) ->
        Restangular.all('uploads').post(upload).then (response) ->
          upload.id = response.id
          upload.name = response.name
          upload.thumbnail = response.thumbnail
      updateParent = (data, model = scope.ngModel) ->
        model.display_order = _.indexOf(collection(), model)
        model.type = sourceType(modelName())
        model.name = data.original_filename
        model.attachable_id = scope.parent.id
        model.attachable_type = capitalize(parentName())
        model[attrs.attribute] = data.url
        uploadToServer(model)

      updateNgModel = (data) ->
        scope.ngModel[attrs.attribute] = data.url
        scope.ngModel["#{attrs.attribute}_preview"] = undefined
]