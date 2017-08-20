<%@ Page Language="C#" AutoEventWireup="true" CodeFile="partial-accounts-add.aspx.cs"
    Inherits="partial_accounts_add" %>

<div ng-include src="'partial-header.aspx'">
</div>
<div class="container margin-fixed">
    <div class="container-inner">
        <div class="new-form-cont" style="color: Red;">
            <ul>
                <li class="li" data-ng-repeat="error in formError">{{error}}</li>
            </ul>
        </div>
        <div class="new-form-cont">
            <span class="caption">Name :</span>
            <br />
            <input type="text" ng-model="AddAccountViewModel.Name" class="player-field player-dark common-header"
                maxlength="50">
        </div>
        <div class="clear">
        </div>
        <div class="new-form-cont">
            <span class="caption">Email :</span>
            <br />
            <input type="text" ng-model="AddAccountViewModel.Email" class="player-field player-dark common-header"
                maxlength="50">
        </div>
        <div class="clear">
        </div>
        <div class="new-form-cont">
            <span class="caption">Contact No. :</span>
            <br />
            <input type="text" ng-model="AddAccountViewModel.ContactNo" class="player-field player-dark common-header"
                maxlength="20">
        </div>
        <div class="clear">
        </div>
        <div class="new-stats">
            <div class="new-form-cont">
                <input type="button" value="ADD THIS ACCOUNT" ng-click="SaveNewAccount()" class="hole-btn common-header">
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
</div>
