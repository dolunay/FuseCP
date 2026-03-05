<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="vsftpd_Settings.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.vsftpd_Settings" %>
<table class="table table-borderless align-middle mb-0 w-100">
		<tr>
			<td class="SubHead text-nowrap">
			    <asp:Label ID="lblConfigFile" runat="server" meta:resourcekey="lblConfigFile" Text="vsftpd Configuration File:"></asp:Label>
			</td>
			<td><asp:TextBox Runat="server" ID="txtConfigFile" Width="300px" CssClass="form-control"></asp:TextBox></td>
		</tr>
</table>
