using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Biz
{
    private DbDroid _biz = new DbDroid();

    public Droid_Member GetMember(Guid memberId)
    {
        return _biz.Droid_Members.Where(P => P.ID == memberId).FirstOrDefault();
    }

    public IList<Droid_Account> GetMemberAccounts(Guid memberId)
    {
        return _biz.Droid_Accounts.Where(P => P.Owner == memberId).ToList();
    }

    public IList<Droid_Transaction> GetMemberAccountsTransactions(Guid accountId)
    {
        return _biz.Droid_Transactions.Where(P => P.Account == accountId).ToList();
    }

    public Boolean DeleteAccount(Guid id)
    {
        var obj = _biz.Droid_Accounts.Where(P => P.ID == id).FirstOrDefault();
        _biz.Droid_Accounts.DeleteOnSubmit(obj);
        var trans = _biz.Droid_Transactions.Where(P => P.Account == id).ToList();
        foreach (var item in trans)
        {
            _biz.Droid_Transactions.DeleteOnSubmit(item);
        }
        _biz.SubmitChanges();
        return true;
    }

    public Boolean DeleteTransaction(Guid id)
    {
        var obj = _biz.Droid_Transactions.Where(P => P.ID == id).FirstOrDefault();
        _biz.Droid_Transactions.DeleteOnSubmit(obj);
        _biz.SubmitChanges();
        return true;
    }

    public Droid_Member Login(String email, String password)
    {
        return _biz.Droid_Members.Where(P => P.Email == email && P.Password == password).FirstOrDefault();
    }

    public Boolean SaveNewAccount(Droid_Account obj)
    {
        _biz.Droid_Accounts.InsertOnSubmit(obj);
        _biz.SubmitChanges();
        return true;
    }

    public Boolean UpdateAccount(Droid_Account obj)
    {
        var dbObj = _biz.Droid_Accounts.Where(P => P.ID == obj.ID).FirstOrDefault();
        if (dbObj != null)
        {
            dbObj.ContactNo = obj.ContactNo;
            dbObj.Email = obj.Email;
            dbObj.Name = obj.Name;
            dbObj.Owner = obj.Owner;
            _biz.SubmitChanges();
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean Register(Droid_Member obj)
    {
        var dbObj = _biz.Droid_Members.Where(P => P.Email == obj.Email).FirstOrDefault();
        if (dbObj == null)
        {
            _biz.Droid_Members.InsertOnSubmit(obj);
            _biz.SubmitChanges();
            return true;
        }
        else
        {
            throw new Exception("Already account exists for email :" + obj.Email);
        }
    }

    public Boolean AddNewTransaction(Droid_Transaction obj)
    {
        _biz.Droid_Transactions.InsertOnSubmit(obj);
        _biz.SubmitChanges();
        return true;
    }

    public Boolean UpdateTransaction(Droid_Transaction obj)
    {
        var dbObj = _biz.Droid_Transactions.Where(P => P.ID == obj.ID).FirstOrDefault();
        if (dbObj != null)
        {
            dbObj.Account = obj.Account;
            dbObj.Amount = obj.Amount;
            dbObj.Date = obj.Date;
            dbObj.Effect = obj.Effect;
            dbObj.Remark = obj.Remark;
            _biz.SubmitChanges();
            return true;
        }
        else
        {
            return false;
        }
    }
}