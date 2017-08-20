<%@ Page Language="C#" AutoEventWireup="true" CodeFile="partial-login.aspx.cs" Inherits="partial_login" %>

<div class="header-wrap top-head common-header fixed">
    <select class="tinynav back-btn bg-menu-icon" data-ng-change="Navigate()" data-ng-model="SelectedMenu1" id="ddl-menu" data-ng-if="loggedInUser">
        <option data-ng-repeat="menuItem in Menu" value="{{menuItem.ID}}">{{menuItem.Text}}</option>
    </select>
    <div class="select-data">
        {{CurrentPageTitle}}
    </div>
    <div class="next-btn">
    </div>
</div>
<div class="clear">
</div>
<div class="container margin-fixed">
    <div class="container-inner">
        <div class="new-form-cont" style="color: Red;">
        </div>
        <div class="new-form-cont">
            <span class="caption">Email :</span>
            <br />
            <input type="text" ng-model="Email" class="player-field player-dark common-header" maxlength="50">
        </div>
        <div class="clear">
        </div>
        <div class="new-form-cont">
            <span class="caption">Password :</span>
            <br />
            <input type="password" ng-model="Password" class="player-field player-dark common-header" maxlength="20">
        </div>
        <div class="clear">
        </div>
        <div class="new-stats">
            <div class="new-form-cont">
                <input type="button" ng-click="Login()" name="btnLogin" value="LOGIN" class="hole-btn common-header">
            </div>
            <div class="new-form-cont" style="margin-top: 40px;">
                <input type="button" data-ng-click="RedirectToRegister()" value="REGISTER HERE" class="hole-btn common-header-green">
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
</div>
