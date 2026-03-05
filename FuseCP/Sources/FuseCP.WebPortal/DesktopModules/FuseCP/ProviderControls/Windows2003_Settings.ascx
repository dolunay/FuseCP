<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Windows2003_Settings.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.Windows2003_Settings" %>
<table class="table table-borderless align-middle mb-0 w-100" width="100%">
		<tr>
			<td class="SubHead text-nowrap" width="200">
			    <asp:Label ID="lblSpacesFolder" runat="server" meta:resourcekey="lblSpacesFolder" Text="User Packages Folder:"></asp:Label>
			</td>
			<td width="100%"><asp:TextBox Runat="server" ID="txtFolder" Width="300px" CssClass="form-control"></asp:TextBox></td>
		</tr>
</table>
