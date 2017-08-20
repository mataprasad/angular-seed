using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class JsonResponse
{
    public void Write(Object obj)
    {
        try
        {
            SetJsonResponse();
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(obj, Formatting.Indented, new IsoDateTimeConverter()));
        }
        catch (Exception ex)
        {
            WriteError(ex.Message);
        }
    }

    public void WriteError(String errorMessage)
    {
        SetJsonResponse();
        HttpContext.Current.Response.StatusCode = 500;
        HttpContext.Current.Response.Write(errorMessage);
    }

    private void SetJsonResponse()
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.ClearHeaders();
        HttpContext.Current.Response.ContentType = @"appliction/json";
    }
}