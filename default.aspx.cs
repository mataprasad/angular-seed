using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _default : Pagebase
{
    //protected String JsonData = String.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Guid memberId = (Request.QueryString["id"] == null ? Guid.Empty : new Guid(Request.QueryString["id"]));
        //Droid_Member member = null;
        //IList<Droid_Account> accounts = null;
        //var txt = new System.Text.StringBuilder();

        //member = __Biz.GetMember(memberId);
        //accounts = __Biz.GetMemberAccounts(memberId);

        //if (member != null)
        //{
        //    txt.AppendFormat(@"_member = {0};", JsonConvert.SerializeObject(member, Formatting.Indented,new IsoDateTimeConverter()));
        //    txt.AppendLine();
        //}

        //if (member != null)
        //{
        //    txt.AppendFormat(@"_memberAccounts = {0};", JsonConvert.SerializeObject(accounts,Formatting.Indented, new IsoDateTimeConverter()));
        //    txt.AppendLine();
        //}
        //JsonData = txt.ToString();
    }
}