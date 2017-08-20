using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public partial class Droid_Account
{
    public String EmailMD5Hash
    {
        get
        {
            return Common.CreateMD5Hash(this.Email);
        }
    }
}

public partial class Droid_Member
{
    public String EmailMD5Hash
    {
        get
        {
            return Common.CreateMD5Hash(this.Email);
        }
    }
}
