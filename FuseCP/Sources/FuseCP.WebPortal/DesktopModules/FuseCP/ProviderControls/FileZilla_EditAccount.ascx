<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileZilla_EditAccount.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.FileZilla_EditAccount" %>
<table class="table table-borderless align-middle mb-0 w-100">
	<tr>
		<td class="SubHead align-top" >
		    <asp:Label ID="lblAccessRights" runat="server" meta:resourcekey="lblAccessRights" Text="Access rights:"></asp:Label>
		</td>
		<td class="Normal">
			<asp:CheckBox id="chkRead" runat="server" meta:resourcekey="chkRead" Text="Read" Checked="True"></asp:CheckBox>
			<br/>
			<asp:CheckBox id="chkWrite" runat="server" meta:resourcekey="chkWrite" Text="Write" Checked="True"></asp:CheckBox>
		</td>
	</tr>
</table>
