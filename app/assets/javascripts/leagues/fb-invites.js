(function(league_id) {
    function statusChangeCallback(response) {
        if (response.status === 'connected') {
            var container = document.getElementById('mfsBtn'),
                inviteBtn = document.createElement('a'),
                inviteCallback = function() { renderLeagueInvite(league_id); };
            inviteBtn.href = '#';
            inviteBtn.classList.add('btn');
            inviteBtn.classList.add('btn-success');
            inviteBtn.innerHTML = 'Send Invite(s)';
            inviteBtn.onclick = inviteCallback;

            container.innerHTML = '';
            container.appendChild(inviteBtn);
        }
    }

    // This function is called when someone finishes with the Login
    // Button.  See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    }

    window.fbAsyncInit = function () {
        FB.init({
            appId: '653406498110718',
            cookie: true,  // enable cookies to allow the server to access
                           // the session
            xfbml: true,  // parse social plugins on this page
            version: 'v2.2' // use version 2.2
        });

        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    };

    // Load the SDK asynchronously
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {
            return;
        }
        js = d.createElement(s);
        js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));


    function renderLeagueInvite(league_id) {
        FB.ui({
            method: 'send',
            link: 'http://www.fantasy-politics.co/invites/' + league_id
        }, sendResponse);

        function sendResponse(response) {
            console.log(response);
        }
    }

}(window.LEAGUE_ID));