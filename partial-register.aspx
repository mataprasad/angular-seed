<%@ Page Language="C#" AutoEventWireup="true" CodeFile="partial-register.aspx.cs" Inherits="partial_register" %>

<div ng-include src="'partial-header.aspx'">
</div>
<div class="container margin-fixed">
    <div class="container-inner">
        <div class="new-form-cont" style="color: Red;">
            <ul>
                <li class="li" data-ng-repeat="error in CurrentPageError">{{error}}</li>
            </ul>
        </div>
        <div class="new-form-cont">
            <span class="caption">Name :</span>
            <br />
            <input type="text" data-ng-model="RegistartionViewModel.Name" data-ng-required="" class="player-field player-dark common-header" data-ng-maxlength="50" maxlength="50">
        </div>
        <div class="clear">
        </div>
        <div class="new-form-cont">
            <span class="caption">Email :</span>
            <br />
            <input type="email" data-ng-model="RegistartionViewModel.Email" data-ng-required="" class="player-field player-dark common-header" data-ng-maxlength="50" maxlength="50">
        </div>
        <div class="clear">
        </div>
        <div class="new-form-cont">
            <span class="caption">Password :</span>
            <br />
            <input type="password" data-ng-model="RegistartionViewModel.Password" data-ng-required="" data-ng-minlength="6" data-ng-maxlength="20" class="player-field player-dark common-header" maxlength="20">
        </div>
        <div class="clear">
        </div>
        <div class="new-form-cont">
            <span class="caption">Confirm Password :</span>
            <br />
            <input type="password" data-ng-model="RegistartionViewModel.ConfirmPassword" data-ng-required="" data-ng-minlength="6" data-ng-maxlength="20" class="player-field player-dark common-header" maxlength="20">
        </div>
        <div class="clear">
        </div>
        <div class="new-stats">
            <div class="new-form-cont">
                <input type="button" data-ng-click="Register()" value="REGISTER" class="hole-btn common-header">
            </div>
            <div class="new-form-cont" style="margin-top: 40px;">
                <input type="button" data-ng-click="RedirectToLogin()" value="GO TO LOGIN PAGE" class="hole-btn common-header-green">
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
</div>

