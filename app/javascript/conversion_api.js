$('#size_form').submit(function (e) {
    e.preventDefault()
    var error =  document.getElementById('error')
    var resultField = document.getElementById('converted_size')
    var initial_national = document.getElementById('initial_national')
    var size = document.getElementById('size')
    var target_national = document.getElementById('target_national')
    var csrfToken = $('meta[name="csrf-token"]').attr('content');
    if (initial_national.value && size.value && target_national.value) {
        $.ajax({
            type: 'POST',
            url: '/web_conversion/size_convert',
            data: {initial_national: initial_national.value, size: size.value, target_national: target_national.value, authenticity_token: csrfToken},
            success: function (res) {
                if(res?.data?.exception === true) {
                    error.innerText = res?.data?.response
                    resultField.value = ""
                } else {
                    resultField.value = res?.data?.response
                    error.innerText = ""
                }
            }
        })
    } else {
        error.innerText = 'Please fill all required fields'
    }
})