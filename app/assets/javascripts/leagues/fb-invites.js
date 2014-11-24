
    function statusChangeCallback(response) {
        if (response.status === 'connected') {
            renderMFS();
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
            debugger;
            var mfsList = document.getElementById('mfsList'),
                mfsForm = document.createElement('form'),
                btnContainer = document.getElementById('mfsBtn');

            mfsForm.id = 'mfsForm';

            // Iterate through the array of friends object and create a checkbox for each one.
            for(var i = 0; i < response.data.length; i++) {
                var friendItem = document.createElement('a');
                friendItem.href = '#';
                friendItem.classList.add('list-group-item');
                friendItem.id = 'friend_' + response.data[i].id;
                friendItem.innerHTML = '<input type="checkbox" name="friends" value="'
                + response.data[i].id
                + '" />' + response.data[i].name;
                mfsForm.appendChild(friendItem);
            }
            mfsList.innerHTML = '';
            mfsList.appendChild(mfsForm);

            // Create a button to send the Request(s)
            var sendButton = document.createElement('input');
            sendButton.type = 'button';
            sendButton.classList.add('btn');
            sendButton.classList.add('btn-success');
            sendButton.value = 'Send Request(s)';
            sendButton.onclick = sendRequest;
            btnContainer.appendChild(sendButton);
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