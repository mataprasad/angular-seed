//Register controller
app.controller('RegistrationController', function ($scope, $http, $location, $rootScope) {

    $rootScope.CurrentPageTitle = "REGISTER";

    $scope.Register = function () {
        window.__loadingOn();
        if (validate()) {
            $http.get(window.__ServiceURL + "action=reg&name=" + $scope.RegistartionViewModel.Name + "&email=" + $scope.RegistartionViewModel.Email + "&pwd=" + $scope.RegistartionViewModel.Password).success(function (data, status, headers, config) {
                document.location = "#/login";
            }).error(function (data, status, headers, config) {
                alert(data);
                window.__loadingOff();
            });
        }
    }

    $scope.RedirectToLogin = function () {
        $location.path("/login");
    }

    var validate = function () {
        $rootScope.CurrentPageError = [];

        if ($scope.RegistartionViewModel.Name) {
            $scope.RegistartionViewModel.Name = $scope.RegistartionViewModel.Name.trim();
        }

        if ($scope.RegistartionViewModel.Email) {
            $scope.RegistartionViewModel.Email = $scope.RegistartionViewModel.Email.trim();
        }

        if ($scope.RegistartionViewModel.Password) {
            $scope.RegistartionViewModel.Password = $scope.RegistartionViewModel.Password.trim();
        }

        if ($scope.RegistartionViewModel.ConfirmPassword) {
            $scope.RegistartionViewModel.ConfirmPassword = $scope.RegistartionViewModel.ConfirmPassword.trim();
        }

        if (!$scope.RegistartionViewModel.Name) {
            $rootScope.CurrentPageError.push("Name filed is required.");
        }

        if (!$scope.RegistartionViewModel.Email) {
            $rootScope.CurrentPageError.push("Email filed is required and should be valid email address.");
        }

        if (!$scope.RegistartionViewModel.Password) {
            $rootScope.CurrentPageError.push("Password is required and should have min. 6 and max. 10 characters.");
        }

        if (!$scope.RegistartionViewModel.ConfirmPassword) {
            $rootScope.CurrentPageError.push("ConfirmPassword is required and should have min. 6 and max. 10 characters.");
        }

        if ($scope.RegistartionViewModel.ConfirmPassword != $scope.RegistartionViewModel.Password) {
            $rootScope.CurrentPageError.push("Password and Confirm Password should be same.");
        }

        if ($rootScope.CurrentPageError.length > 0) {
            window.__loadingOff();
            return false;
        }
        return true;
    }

    var init = function () {
        $scope.RegistartionViewModel = { Email: "", Password: "", ConfirmPassword: "", Name: "" };
    }

    var initComplete = function () {
        window.__loadingOff();
    }

    init();
    initComplete();
});

//Login controller
app.controller('LoginController', function ($scope, $http, $location, $rootScope) {

    $rootScope.CurrentPageTitle = "LOGIN";

    $scope.Login = function () {
        window.__loadingOn();
        $http.get(window.__ServiceURL + "action=login&email=" + $scope.Email + "&pwd=" + $scope.Password).success(function (data, status, headers, config) {
            $rootScope.CurrenMember = data.Member;
            $rootScope.CurrenMemberAccounts = data.Accounts;
            $rootScope.loggedInUser = data.Member;
            document.location = "#/accounts";
        }).error(function (data, status, headers, config) {
            alert(data);
            window.__loadingOff();
        });
    }

    $scope.RedirectToRegister = function () {
        $location.path("/register");
    }

    var init = function () {
        $scope.Email = "mataprasad045@gmail.com";
        $scope.Password = "";
    }

    var initComplete = function () {
        window.__loadingOff();
    }

    init();
    initComplete();
});

//Accounts controller
app.controller('AccountController', function ($scope, $http, $location, $rootScope) {

    $rootScope.CurrentPageTitle = "ACCOUNTS";
    $scope.CurrenMemberAccountsTransactions = $rootScope.CurrenMemberAccountsTransactions;

    $scope.SelectAccount = function (id, obj) {
        window.__loadingOff();
        window.__loadingOn();
        $http.get(window.__ServiceURL + "action=transaction&id=" + id).success(function (data, status, headers, config) {
            $rootScope.CurrenMemberAccountsTransactions = data;
            $rootScope.account = obj;
            $rootScope.CurrentPageTitle = "TRANSACTIONS";
            document.location = "#/accounts/detail";
        }).error(function (data, status, headers, config) {
            alert(data);
            window.__loadingOff();
        });
    }

    var init = function () {
    }

    var initComplete = function () {
        window.__loadingOff();
    }

    init();
    initComplete();
});