<%@ Page Language="C#" AutoEventWireup="true" CodeFile="partial-accounts-detail.aspx.cs" Inherits="partial_accounts_detail" %>

<div ng-include src="'partial-header.aspx'">
</div>
<div class="container margin-fixed">
    <div class="container-inner">
        <div class="list-base">
            <ul>
                <li data-ng-repeat="tran in CurrenMemberAccountsTransactions" class="btnLi"><a href="javascript:void(0);" ng-click="SelectEntry(tran)">
                    <div class="color-box">
                        <div data-ng-if="tran.Effect > 0">
                            <!-- code to render a large video block-->
                            <img src="Content/app/images/thumbs_up.png" />
                        </div>
                        <div data-ng-if="tran.Effect < 0">
                            <!-- code to render the regular video block -->
                            <img src="Content/app/images/thumbs_down.png" />
                        </div>
                    </div>
                    {{tran.Amount}}
                        <h5>Date : {{tran.Date | date : "dd/MMM/yyyy"}}
                            <br />
                            Remark : {{tran.Remark}}
                        </h5>
                </a></li>
            </ul>
        </div>
    </div>
</div>

