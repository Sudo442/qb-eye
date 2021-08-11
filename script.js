$(document).on('click', '.menu-item', function(e) {
    e.preventDefault();
    if ($(this).data('event') != null && $(this).data('event') != undefined) {
        $.post('http://qb-eye/DoSomething', JSON.stringify({event: $(this).data('event'), type: $(this).data('eventtype'), parameter: $(this).data('eventpara')}));
        setTimeout(function(){
            CloseEye()
        }, 50);
    }
});

OpenEye = function() {
    $('.main-eye-container').show()
}

CloseEye = function() {
    $(".eye-interact").removeClass("found");
    setTimeout(function(){
        $('.main-eye-container').hide()
        $('.menu-items-container').hide()
        $.post(`http://qb-eye/CloseUi`, JSON.stringify({}));
    }, 15);
}

OpenMenu = function() {
    $('.menu-items-container').show()
}

CloseMenu = function() {
    $('.menu-items-container').hide()
}

SetupOptions = function(data) {
    $('.menu-items-container').html('')
    if (!data.specific) {
        for (const [key, value] of Object.entries(data.currentdata)) {
            if (key != 'Job' && key != 'MetaData' && key != 'UseDuty') {
                var AddOption = '<div class="menu-item" data-event='+value['EventName']+' data-eventtype='+value['EventType']+' data-eventpara='+value['EventParameter']+'>'+value['Logo']+' <span class="menu-text">'+value['Name']+'</span></div>'
                $('.menu-items-container').append(AddOption);
            }
        }
        $(".eye-interact").addClass("found");
    } else {
        var MenuData = data.currentdata
        var AddOption = '<div class="menu-item" data-event='+MenuData['EventName']+' data-eventtype='+MenuData['EventType']+' data-eventpara='+MenuData['EventParameter']+'>'+MenuData['Logo']+' <span class="menu-text">'+MenuData['Name']+'</span></div>'
        $('.menu-items-container').append(AddOption); 
        $(".eye-interact").addClass("found");
    }  
}

ResetEye = function() {
 $('.menu-items-container').html('')
 $(".eye-interact").removeClass("found");
}

window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case "OpenEye":
            OpenEye()
            break;
        case "OpenMenu":
            OpenMenu()
            break;
        case "CloseMenu":
            CloseMenu()
            break;
        case "ResetEye":
            ResetEye();
            break;
        case "SetData":
            SetupOptions(event.data);
            break;
        case "ForceRefresh":
            ResetEye()
            CloseEye()
            CloseMenu()
            break;
    }
});

window.addEventListener("keyup", function onEvent(event) {
    // Close menu when key is released
    if (event.key == 'g' || event.key == 'G') {
        CloseEye()
    }
});

window.addEventListener("mousedown", function onEvent(event) {
    if (event.button == 2) {
        CloseMenu()
        $.post(`http://qb-eye/CloseMenu`, JSON.stringify({}));
    }
});