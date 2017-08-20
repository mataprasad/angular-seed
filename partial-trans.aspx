<%@ Page Language="C#" AutoEventWireup="true" CodeFile="partial-trans.aspx.cs" Inherits="partial_trans_add" %>

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
            <span class="caption">Date :</span>
            <br />
            <input type="text" value="{{TranViewModel.Date | date : 'yyyy-MMM-dd'}}" readonly="readonly" class="player-field player-dark common-header" maxlength="50">
        </div>
        <div class="clear">
        </div>
        <div class="new-form-cont">
            <span class="caption">Amount :</span>
            <br />
            <input type="text" ng-model="TranViewModel.Amount" class="player-field player-dark common-header" maxlength="50">
        </div>
        <div class="clear">
        </div>
        <div class="new-form-cont">
            <span class="caption">Transaction Type :</span>
            <br />
            <%--            <select class="select-date common-header">
                <option value="-1">GIVEN TO [{{TranViewModel.Account.Name}}]</option>
                <option value="1">TAKEN FROM [{{TranViewModel.Account.Name}}]</option>
            </select>--%>
            <input type="radio" ng-model="TranViewModel.Effect" value="-1" /><span class="caption" style="color: red;"> GIVEN TO [{{TranViewModel.Account.Name}}]
            </span>
            <br />
            <input type="radio" ng-model="TranViewModel.Effect" value="1" /><span class="caption" style="color: green;"> TAKEN FROM [{{TranViewModel.Account.Name}}]</span>
        </div>
        <div class="clear">
        </div>
        <div class="new-form-cont">
            <span class="caption">Remark :</span>
            <br />
            <textarea ng-model="TranViewModel.Remark" class="player-field player-dark common-header" style="height: 100px;" maxlength="200"></textarea>
        </div>
        <div class="clear">
        </div>
        <div class="new-stats">
            <div class="new-form-cont">
                <input type="button" value="SAVE THIS ENTRY" ng-click="SaveNewEntry()" class="hole-btn common-header">
            </div>
            <div class="new-form-cont" data-ng-if="TranViewModel.ID" style="margin-top: 30px;">
                <input type="button" ng-click="DeleteEntry(TranViewModel.ID,TranViewModel.Account)" value="DELETE THIS ENTRY" class="hole-btn common-header-red">
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
</div>
