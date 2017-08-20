using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

public partial class Api_service : Pagebase
{
    private JsonResponse jsonResponse = new JsonResponse();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            var action = Request["action"];
            switch (action)
            {
                case "transaction":
                    GetAllTransaction();
                    break;
                case "login":
                    Login();
                    break;
                case "new-acc":
                    SaveNewAccount();
                    break;
                case "del-entry":
                    DeleteTransaction();
                    break;
                case "save-entry":
                    SaveEntry();
                    break;
                case "del-acc":
                    DeleteAccount();
                    break;
                case "edit-acc":
                    UpdateAccount();
                    break;
                case "reg":
                    Register();
                    break;
                default:
                    new JsonResponse().WriteError("Invalid request.");
                    break;
            }
        }
        catch (Exception ex)
        {
            jsonResponse.WriteError(ex.Message);
        }
    }

    private void Register()
    {
        var obj = new Droid_Member();
        obj.Password = Request["pwd"];
        obj.Email = Request["email"];
        obj.Name = Request["name"];
        obj.Active = true;
        obj.CreatedOn = DateTime.UtcNow;
        obj.ID = Guid.NewGuid();

        var success = __Biz.Register(obj);
        if (success)
        {
            jsonResponse.Write(success);
        }
        else
        {
            jsonResponse.WriteError("Unable to create the new account!");
        }
    }
    private void UpdateAccount()
    {
        var obj = new Droid_Account();
        obj.ID = new Guid(Request["id"]);
        obj.ContactNo = Request["contact"];
        obj.Email = Request["email"];
        obj.Name = Request["name"];
        obj.Owner = new Guid(Request["owner"]);

        var success = __Biz.UpdateAccount(obj);
        if (success)
        {
            var accounts = __Biz.GetMemberAccounts(obj.Owner.Value);

            var response = new { Accounts = accounts };
            jsonResponse.Write(response);
        }
        else
        {
            jsonResponse.WriteError("Unable to save the new account!");
        }
    }

    private void DeleteAccount()
    {
        Guid accountId = (Request["id"] == null ? Guid.Empty : new Guid(Request["id"]));
        Guid user = (Request["user"] == null ? Guid.Empty : new Guid(Request["user"]));
        if (accountId != Guid.Empty)
        {
            __Biz.DeleteAccount(accountId);
            var member = __Biz.GetMember(user);
            var accounts = __Biz.GetMemberAccounts(user);

            var response = new { Member = member, Accounts = accounts };
            jsonResponse.Write(response);
        }
        else
        {
            jsonResponse.WriteError("Unable to delete this account!");
        }
    }

    private void SaveEntry()
    {
        var obj = new Droid_Transaction();
        obj.ID = Guid.Empty;
        if (!(String.IsNullOrWhiteSpace(Request["id"]) || Request["id"] == "null"))
        {
            obj.ID = new Guid(Request["id"]);
        }
        obj.Account = new Guid(Request["acc"]);
        obj.Amount = Convert.ToDecimal(Request["amt"]);
        obj.Date = DateTime.Now;
        obj.Effect = Convert.ToInt32(Request["eff"]);
        obj.Remark = Request["remark"];

        var success = false;
        if (obj.ID != Guid.Empty)
        {
            success = __Biz.UpdateTransaction(obj);
        }
        else
        {
            obj.ID = Guid.NewGuid();
            success = __Biz.AddNewTransaction(obj);
        }
        if (success)
        {
            jsonResponse.Write(success);
        }
        else
        {
            jsonResponse.WriteError("Unable to save the new entry!");
        }
    }
    private void GetAllTransaction()
    {
        Guid accountId = (Request["id"] == null ? Guid.Empty : new Guid(Request["id"]));
        if (accountId != Guid.Empty)
        {
            jsonResponse.Write(__Biz.GetMemberAccountsTransactions(accountId));
        }
        else
        {
            jsonResponse.WriteError("Invalid account selection!");
        }
    }

    private void DeleteTransaction()
    {
        Guid tranId = (Request["id"] == null ? Guid.Empty : new Guid(Request["id"]));
        if (tranId != Guid.Empty)
        {
            jsonResponse.Write(__Biz.DeleteTransaction(tranId));
        }
        else
        {
            jsonResponse.WriteError("Invalid account selection!");
        }
    }

    private void Login()
    {
        var user = __Biz.Login(Request["email"], Request["pwd"]);
        if (user != null)
        {
            var member = __Biz.GetMember(user.ID);
            var accounts = __Biz.GetMemberAccounts(user.ID);

            var response = new { Member = member, Accounts = accounts };
            jsonResponse.Write(response);
        }
        else
        {
            jsonResponse.WriteError("Invalid login details!");
        }
    }

    private void SaveNewAccount()
    {
        var obj = new Droid_Account();
        obj.ID = Guid.NewGuid();
        obj.ContactNo = Request["contact"];
        obj.Email = Request["email"];
        obj.Name = Request["name"];
        obj.Owner = new Guid(Request["owner"]);

        var success = __Biz.SaveNewAccount(obj);
        if (success)
        {
            var accounts = __Biz.GetMemberAccounts(obj.Owner.Value);

            var response = new { Accounts = accounts };
            jsonResponse.Write(response);
        }
        else
        {
            jsonResponse.WriteError("Unable to save the new account!");
        }
    }
}