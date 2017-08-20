<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="_default" %>

<!DOCTYPE html>
<html data-ng-app="droidApp" lang="en">
<head>
    <title>
        <%=Common.APPLICATION_NAME%></title>
    <link href="<%=Page.ResolveClientUrl("~/favicon.ico") %>" rel="shortcut icon" type="image/x-icon" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="HandheldFriendly" content="true" />
    <meta name="robots" content="noindex, nofollow" />
    <link href="<%=Page.ResolveClientUrl("~/Content/app/css/style.css") %>" rel="stylesheet" />
    <style type="text/css">
        .tinynav
        {
            border: medium none;
            border-radius: 0;
            height: 25px;
            padding: 13px;
            position: absolute;
            top: 13px;
            left: 12px;
            width: 25px;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            position: absolute;
            left: 10px;
            top: 7px;
        }
    </style>
</head>
<body>
    <div id="main">
        <div class="wrapper">
            <div style="margin: 0px; padding: 0px; border: 0px solid black; height: 100%;" data-ng-view="">
            </div>
        </div>
    </div>
    <script type="text/javascript" src="<%=Page.ResolveClientUrl("~/Content/app/js/angular.js") %>"></script>
    <script type="text/javascript" src="<%=Page.ResolveClientUrl("~/Content/app/js/angular-route.js") %>"></script>
    <script type="text/javascript" src="<%=Page.ResolveClientUrl("~/Content/app/js/jquery.min.js") %>"></script>
    <script type="text/javascript" src="<%=Page.ResolveClientUrl("~/js.aspx") %>"></script>
    <script type="text/javascript">
        window.__loadingOn();

        window.__memberAccountsTransactions = [];
        window.__member = {};
        window.__memberAccounts = [];

        var app = angular.module('droidApp', ['ngRoute']);
        app.config(function ($routeProvider) {
            $routeProvider.when('/accounts',
            {
                controller: 'AccountController',
                templateUrl: '<%=Page.ResolveClientUrl("~/partial-accounts-list.aspx")%>'
            }).when('/accounts/add',
            {
                controller: 'AccountsController',
                templateUrl: '<%=Page.ResolveClientUrl("~/partial-accounts-add.aspx")%>'
            }).when('/accounts/detail',
            {
                controller: 'AccountsController',
                templateUrl: '<%=Page.ResolveClientUrl("~/partial-accounts-detail.aspx")%>'
            }).when('/accounts/edit',
            {
                controller: 'AccountsController',
                templateUrl: '<%=Page.ResolveClientUrl("~/partial-accounts-edit.aspx")%>'
            }).when('/register',
            {
                controller: 'RegistrationController',
                templateUrl: '<%=Page.ResolveClientUrl("~/partial-register.aspx")%>'
            }).when('/login',
            {
                controller: 'LoginController',
                templateUrl: '<%=Page.ResolveClientUrl("~/partial-login.aspx")%>'
            }).when('/tran',
            {
                controller: 'AccountsController',
                templateUrl: '<%=Page.ResolveClientUrl("~/partial-trans.aspx")%>'
            }).otherwise({ redirectTo: '/login' });
        });
        app.controller('AccountsController', function ($scope, $http, $location, $rootScope) {
            var _member = {};
            var _memberAccounts = [];
            var _memberAccountsTransactions = [];
            _member = window.__member;
            _memberAccounts = window.__memberAccounts;
            _memberAccountsTransactions = window.__memberAccountsTransactions;

            $scope.CurrenMember = _member;
            $scope.CurrenMemberAccounts = _memberAccounts;
            $scope.CurrenMemberAccountsTransactions = _memberAccountsTransactions;
            $scope.Email = "mataprasad045@gmail.com";
            $scope.Password = "";
            $scope.AddAccountViewModel = $rootScope.AddAccountViewModel;
            $scope.formError = [];
            $scope.TranPageTitle = $rootScope.TranPageTitle;
            $scope.TranViewModel = $rootScope.TranViewModel;


            $scope.SelectAccount = function (id, obj) {
                window.__loadingOff();
                window.__loadingOn();
                $http.get("<%=Page.ResolveClientUrl("~/api/service.aspx?action=transaction&id=")%>" + id).success(function (data, status, headers, config) {
                    window.__memberAccountsTransactions = data;
                    $rootScope.account = obj;
                    document.location = "#/accounts/detail";
                }).error(function (data, status, headers, config) {
                    alert(data);
                    window.__loadingOff();
                });
            }

            $scope.Login = function () {
                window.__loadingOn();
                $http.get("<%=Page.ResolveClientUrl("~/api/service.aspx?action=login&email=")%>" + $scope.Email + "&pwd=" + $scope.Password).success(function (data, status, headers, config) {
                    window.__member = data.Member;
                    window.__memberAccounts = data.Accounts;
                    $rootScope.loggedInUser = data.Member;
                    document.location = "#/accounts";
                }).error(function (data, status, headers, config) {
                    alert(data);
                    window.__loadingOff();
                });
            }

            $scope.AddAccount = function () {
                window.__loadingOn();
                $rootScope.AddAccountViewModel = { Name: "", Email: "", ContactNo: "", ID: null };
                document.location = "#/accounts/add";
            }

            $scope.SaveNewAccount = function () {
                window.__loadingOn();
                $scope.formError = [];

                if ($scope.AddAccountViewModel.Name.trim() == "") {
                    $scope.formError.push("Name is required.");
                }

                if ($scope.AddAccountViewModel.Email.trim() == "") {
                    $scope.formError.push("Email is required.");
                }

                if ($scope.AddAccountViewModel.ContactNo.trim() == "") {
                    $scope.formError.push("ContactNo is required.");
                }
                if ($scope.formError.length > 0) {
                    window.__loadingOff();
                    return;
                }
                $http.get("<%=Page.ResolveClientUrl("~/api/service.aspx?action=new-acc&name=")%>" + $scope.AddAccountViewModel.Name + "&email=" + $scope.AddAccountViewModel.Email + "&contact=" + $scope.AddAccountViewModel.ContactNo + "&owner=" + $rootScope.loggedInUser.ID).success(function (data, status, headers, config) {
                    window.__memberAccounts = data.Accounts;
                    document.location = "#/accounts";
                }).error(function (data, status, headers, config) {
                    alert(data);
                    window.__loadingOff();
                });
            }

            $scope.AddEntry = function () {
                window.__loadingOn();
                $rootScope.TranPageTitle = "NEW ENTRY";
                $rootScope.TranViewModel = { Amount: "", Effect: -1, Date: new Date(), Remark: "", Account: $rootScope.account, ID: null };
                document.location = "#/tran";
            }

            $scope.SelectEntry = function (obj) {
                window.__loadingOn();
                $rootScope.TranPageTitle = "EDIT ENTRY";
                $rootScope.TranViewModel = { Amount: obj.Amount, Effect: obj.Effect, Date: obj.Date, Remark: obj.Remark, Account: $rootScope.account, ID: obj.ID };
                document.location = "#/tran";
            }

            $scope.SaveNewEntry = function () {
                window.__loadingOn();
                $scope.formError = [];

                if ($scope.TranViewModel.Amount.toString().trim() == "") {
                    $scope.formError.push("Amount is required.");
                }

                if ($scope.TranViewModel.Remark.trim() == "") {
                    $scope.formError.push("Remark is required.");
                }

                if ($scope.formError.length > 0) {
                    window.__loadingOff();
                    return;
                }

                $http.get("<%=Page.ResolveClientUrl("~/api/service.aspx?action=save-entry&id=")%>" + $scope.TranViewModel.ID + "&acc=" + $scope.TranViewModel.Account.ID + "&amt=" + $scope.TranViewModel.Amount + "&eff=" + $scope.TranViewModel.Effect + "&date=" + $scope.TranViewModel.Date + "&remark=" + $scope.TranViewModel.Remark).success(function (data, status, headers, config) {
                    $rootScope.TranViewModel = { Amount: "", Effect: -1, Date: new Date(), Remark: "", Account: $rootScope.account, ID: null };
                    $scope.SelectAccount($scope.TranViewModel.Account.ID, $scope.TranViewModel.Account);
                }).error(function (data, status, headers, config) {
                    alert(data);
                    window.__loadingOff();
                });
            }

            $scope.DeleteEntry = function (id, account) {
                var yes = confirm("Are you sure to delete this entry ?");
                if (yes) {
                    window.__loadingOn();
                    $http.get("<%=Page.ResolveClientUrl("~/api/service.aspx?action=del-entry&id=")%>" + id).success(function (data, status, headers, config) {
                        $rootScope.TranViewModel = { Amount: "", Effect: -1, Date: new Date(), Remark: "", Account: $rootScope.account, ID: null };
                        $scope.SelectAccount(account.ID, account);
                    }).error(function (data, status, headers, config) {
                        alert(data);
                        window.__loadingOff();
                    });
                }
            }

            $scope.EditAccount = function (account) {
                window.__loadingOn();
                $rootScope.AddAccountViewModel = { Name: account.Name, Email: account.Email, ContactNo: account.ContactNo, ID: account.ID };
                document.location = "#/accounts/edit";
            }

            $scope.UpdateAccount = function () {
                window.__loadingOn();
                $scope.formError = [];

                if ($scope.AddAccountViewModel.Name.trim() == "") {
                    $scope.formError.push("Name is required.");
                }

                if ($scope.AddAccountViewModel.Email.trim() == "") {
                    $scope.formError.push("Email is required.");
                }

                if ($scope.AddAccountViewModel.ContactNo.trim() == "") {
                    $scope.formError.push("ContactNo is required.");
                }
                if ($scope.formError.length > 0) {
                    window.__loadingOff();
                    return;
                }
                $http.get("<%=Page.ResolveClientUrl("~/api/service.aspx?action=edit-acc&name=")%>" + $scope.AddAccountViewModel.Name + "&email=" + $scope.AddAccountViewModel.Email + "&contact=" + $scope.AddAccountViewModel.ContactNo + "&owner=" + $rootScope.loggedInUser.ID + "&id=" + $scope.AddAccountViewModel.ID).success(function (data, status, headers, config) {
                    window.__memberAccounts = data.Accounts;
                    document.location = "#/accounts";
                }).error(function (data, status, headers, config) {
                    alert(data);
                    window.__loadingOff();
                });
            }

            $scope.DeleteAccount = function (id) {
                var yes = confirm("Are you sure to delete this account ?");
                if (yes) {
                    window.__loadingOn();
                    $http.get("<%=Page.ResolveClientUrl("~/api/service.aspx?action=del-acc&id=")%>" + id + "&user=" + $rootScope.loggedInUser.ID).success(function (data, status, headers, config) {
                        $rootScope.AddAccountViewModel = { Name: "", Email: "", ContactNo: "", ID: null };
                        window.__member = data.Member;
                        window.__memberAccounts = data.Accounts;
                        $rootScope.loggedInUser = data.Member;
                        document.location = "#/accounts";
                    }).error(function (data, status, headers, config) {
                        alert(data);
                        window.__loadingOff();
                    });
                }
            }

            window.__loadingOff();
        }).run(function ($rootScope, $location) {

            $rootScope.CurrentPageTitle = "";
            $rootScope.CurrentPageError = [];
            $rootScope.SelectedMenu1 = -1;
            $rootScope.Menu = [];
            $rootScope.Menu.push({ Text: "NAVIGATE TO...", ID: -1 });
            $rootScope.Menu.push({ Text: "ACCOUNTS", ID: 4 });
            $rootScope.Menu.push({ Text: "ADD ACCOUNTS", ID: 1 });
            $rootScope.Menu.push({ Text: "ADD TRANSACTIONS", ID: 2 });
            $rootScope.Menu.push({ Text: "CHANGE PASSWORD", ID: 3 });
            $rootScope.Menu.push({ Text: "LOG OFF", ID: 0 });

            $rootScope.CurrenMember = {};
            $rootScope.CurrenMemberAccounts = [];
            $rootScope.CurrenMemberAccountsTransactions = [];

            $rootScope.Navigate = function () {
                var selectedMenu = angular.element(event.target).val();
                switch (parseInt(selectedMenu)) {
                    case 0:
                        $rootScope.loggedInUser = null;
                        alert("You are sucessfully logout.");
                        $location.path("/login");
                        break;
                    case 1:
                    window.__loadingOn();
                        $location.path("/accounts/add");
                        break;
                    case 2:
                                    window.__loadingOn();
                $rootScope.CurrentPageTitle = "NEW ENTRY";
                $rootScope.TranViewModel = { Amount: "", Effect: -1, Date: new Date(), Remark: "", Account: $rootScope.account, ID: null };
                        $location.path("/tran");
                        break;
                    case 4:
                    window.__loadingOn();
                        $location.path("/accounts");
                        break;
                    default:
                        break;
                }
            }

            $rootScope.$on("$routeChangeStart", function (event, next, current) {
                if (!$rootScope.loggedInUser) {
                    if (next.$$route.originalPath != "/register") {
                        $location.path("/login");
                    }
                } else {
                    if (next.$$route.originalPath == "/login") {
                        event.preventDefault();
                        return;
                    }
                }
            });
        });
    </script>
    <script type="text/javascript" src="<%=Page.ResolveClientUrl("~/Content/app/controller.js") %>"></script>
</body>
</html>
