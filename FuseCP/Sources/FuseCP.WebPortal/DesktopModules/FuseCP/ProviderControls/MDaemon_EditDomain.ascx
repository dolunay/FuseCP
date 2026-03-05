<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MDaemon_EditDomain.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.MDaemon_EditDomain" %>
<table class="table table-borderless align-middle mb-0 w-100">
    <tr>
        <td class="SubHead text-nowrap" width="200"><asp:Label ID="lblCatchAll" runat="server" meta:resourcekey="lblCatchAll" Text="Catch-All Account:"></asp:Label></td>
        <td class="Normal" width="100%">
            <asp:DropDownList ID="ddlCatchAllAccount" runat="server" CssClass="form-control">
            </asp:DropDownList></td>
    </tr>
    <tr>
        <td class="SubHead"><asp:Label ID="lblAbuse" runat="server" meta:resourcekey="lblAbuse" Text="Abuse Account:"></asp:Label></td>
        <td class="Normal">
            <asp:DropDownList ID="ddlAbuseAccount" runat="server" CssClass="form-control">
            </asp:DropDownList></td>
    </tr>
</table>
