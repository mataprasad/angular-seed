<%@ Page Language="C#" AutoEventWireup="true" CodeFile="partial-accounts-list.aspx.cs"
    Inherits="partial_accounts_list" %>

<div ng-include src="'partial-header.aspx'">
</div>
<div class="container margin-fixed">
    <div class="container-inner">
        <div class="list-base">
            <ul>
                <li data-ng-repeat="account in CurrenMemberAccounts | orderBy: 'Name'" class="btnLi"><a class="a-90" href="javascript:void(0);" ng-click="SelectAccount(account.ID,account)">
                    <div class="color-box">
                        <img class="round_img" src="http://www.gravatar.com/avatar/{{account.EmailMD5Hash}}?s=35" />
                    </div>
                    {{account.Name}}
                        <h5>Contact No : {{account.ContactNo}}
                            <br />
                            Email : {{account.Email}}
                        </h5>
                </a>
                    <a class="a-edit" ng-click="EditAccount(account)" href="javascript:void(0);" style="">EDIT</a>
                </li>
            </ul>
        </div>
    </div>
</div>
