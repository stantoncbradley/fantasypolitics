// This is called with the results from from FB.getLoginStatus().
function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
        // Logged into your app and Facebook.
        renderMFS();
    } else if (response.status === 'not_authorized') {
        // The person is logged into Facebook, but not your app.
        document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
        // The person is not logged into Facebook, so we're not sure if
        // they are logged into this app or not.
        document.getElementById('status').innerHTML = 'Please log ' +
        'into Facebook.';
    }
}

// This function is called when someone finishes with the Login
// Button.  See the onlogin handler attached to it in the sample
// code below.
function checkLoginState() {
    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
    });
}

window.fbAsyncInit = function() {
    FB.init({
        appId      : '653406498110718',
        cookie     : true,  // enable cookies to allow the server to access
                            // the session
        xfbml      : true,  // parse social plugins on this page
        version    : 'v2.2' // use version 2.2
    });


    // Now that we've initialized the JavaScript SDK, we call
    // FB.getLoginStatus().  This function gets the state of the
    // person visiting this page and can return one of three states to
    // the callback you provide.  They can be:
    //
    // 1. Logged into your app ('connected')
    // 2. Logged into Facebook, but not your app ('not_authorized')
    // 3. Not logged into Facebook and can't tell if they are logged into
    //    your app or not.
    //
    // These three cases are handled in the callback function.

    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
    });

};

// Load the SDK asynchronously
(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));


function renderMFS() {
    // First get the list of friends for this user with the Graph API
    FB.api('/me/friends', function(response) {
        var container = document.getElementById('fb-mfs');
        var mfsList = document.createElement('ul');
        var mfsForm = document.createElement('form');
        mfsList.id = 'mfsList';
        mfsList.class = 'list-group scolling-sponsor-list';
        mfsForm.id = 'mfsForm';

        // Iterate through the array of friends object and create a checkbox for each one.
        for(var i = 0; i < response.data.length; i++) {
            var friendItem = document.createElement('a');
            friendItem.href = '#';
            friendItem.class = 'list-group-item';
            friendItem.id = 'friend_' + response.data[i].id;
            friendItem.innerHTML = '<input type="checkbox" name="friends" value="'
            + response.data[i].id
            + '" />' + response.data[i].name;
            mfsForm.appendChild(friendItem);
        }
        container.innerHTML = '';
        container.appendChild(mfsList);
        mfsList.appendChild(mfsForm);

        // Create a button to send the Request(s)
        var sendButton = document.createElement('input');
        sendButton.type = 'button';
        sendButton.class = 'btn btn-success';
        sendButton.value = 'Send Request(s)';
        sendButton.onclick = sendRequest;
        mfsForm.appendChild(sendButton);
    });

    function sendRequest() {
        // Get the list of selected friends
        var sendUIDs = '';
        var mfsForm = document.getElementById('mfsForm');
        for(var i = 0; i < mfsForm.friends.length; i++) {
            if(mfsForm.friends[i].checked) {
                sendUIDs += mfsForm.friends[i].value + ',';
            }
        }

        // Use FB.ui to send the Request(s)
        FB.ui({method: 'apprequests',
            to: sendUIDs,
            title: 'League Invitation',
            message: 'Join my league on Fantasy Politics!'
        }, requestCallback);
    }

    function requestCallback(response) {
        console.log(response);
    }
}