<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AbilityMailServer_EditDomain.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.AbilityMailServer_EditDomain" %>
<table class="table table-borderless align-middle mb-0 w-100">
    <tr>
        <td class="SubHead text-nowrap" ><asp:Label ID="lblCatchAll" runat="server" meta:resourcekey="lblCatchAll" Text="Catch-All Account:"></asp:Label></td>
        <td class="Normal">
            <asp:DropDownList ID="ddlCatchAllAccount" runat="server" CssClass="form-control">
            </asp:DropDownList></td>
    </tr>
</table>
