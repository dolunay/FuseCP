<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CerberusFTP6_Settings.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.CerberusFTP6_Settings" %>
<table class="table table-borderless align-middle mb-0 w-100">
	<tr>
	    <td class="SubHead text-nowrap">
            <asp:Label ID="lblServiceUrl" runat="server" meta:resourcekey="lblServiceUrl" Text="Web Services URL:"></asp:Label>
        </td>
	    <td class="Normal align-top">
            <asp:TextBox Runat="server" ID="txtServiceUrl" CssClass="form-control"></asp:TextBox></td>
	</tr>
	<tr>
	    <td class="SubHead text-nowrap">
            <asp:Label ID="lblAdminLogin" runat="server" meta:resourcekey="lblAdminLogin" Text="Admin Login:"></asp:Label>
        </td>
	    <td class="Normal align-top">
            <asp:TextBox Runat="server" ID="txtUsername" CssClass="form-control"></asp:TextBox></td>
	</tr>
	<tr>
	    <td class="SubHead text-nowrap">
            <asp:Label ID="lblAdminPassword" runat="server" meta:resourcekey="lblAdminPassword" Text="Admin Password:"></asp:Label>
       </td>
	    <td class="Normal align-top">
            <asp:TextBox Runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
      </td>
	</tr>
</table>
