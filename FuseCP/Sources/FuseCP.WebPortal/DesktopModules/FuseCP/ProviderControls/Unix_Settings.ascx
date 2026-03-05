<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Unix_Settings.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.Unix_Settings" %>
<table class="table table-borderless align-middle mb-0 w-100">
		<tr>
			<td class="SubHead text-nowrap">
			    <asp:Label ID="lblUsersHome" runat="server" meta:resourcekey="lblUsersHome" Text="Users Home Directory:"></asp:Label>
			</td>
			<td><asp:TextBox Runat="server" ID="txtUsersHome" Width="300px" CssClass="form-control" MaxLength="255"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="SubHead text-nowrap">
			    <asp:Label ID="lblLogDir" runat="server" meta:resourcekey="lblLogDir" Text="Log Directory:"></asp:Label>
			</td>
			<td><asp:TextBox Runat="server" ID="txtLogDir" Width="300px" CssClass="form-control" MaxLength="255"></asp:TextBox></td>
		</tr>
</table>
