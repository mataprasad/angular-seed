<%@ Page Language="C#" AutoEventWireup="true" CodeFile="partial-header.aspx.cs" Inherits="partial_header" %>

<div class="header-wrap top-head common-header fixed">
    <select class="tinynav back-btn bg-menu-icon" data-ng-change="Navigate()" data-ng-model="SelectedMenu1"
        id="ddl-menu" data-ng-if="loggedInUser">
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
