<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CerberusFTP6_EditAccount.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.CerberusFTP6_EditAccount" %>
<table class="table table-borderless align-middle mb-0 w-100">
	<tr>
            <td class="SubHead align-top" style="width:150px;">
            <asp:Label ID="lblAccessRights" runat="server" meta:resourcekey="lblAccessRights" Text="Access rights:"></asp:Label>
       </td>
		<td class="Normal">
            <asp:CheckBox ID="chkRead" runat="server" meta:resourcekey="chkRead" Text="Read" Checked="True" />
            <br/>
            <asp:CheckBox ID="chkWrite" runat="server" meta:resourcekey="chkWrite" Text="Write" Checked="True" />
        </td>
	</tr>
</table>
