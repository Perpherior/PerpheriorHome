angular.module('homeApp')
.run([ ()->
  $.cloudinary.config({
    cloud_name: 'perpherior',
    api_key: '831358195454988',
    image_preset: 'sjp7380p',
    audio_preset: 'dp1xktq3',
    file_preset: 'vzsiwhbh'
  })
])