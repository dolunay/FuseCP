<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="IceWarp_EditGroup.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.IceWarp_EditGroup" %>
<%@ Register TagPrefix="dnc" TagName="EditItemsList" Src="../MailEditItems.ascx" %>
<table class="table table-borderless align-middle mb-0 w-100">
	<tr>
		<td class="SubHead">
		    <asp:Label ID="lblGroupMembers" runat="server" meta:resourcekey="lblGroupMembers" Text="Group e-mails:"></asp:Label>
		</td>
		<td class="Normal">
			<dnc:EditItemsList id="mailEditItems" runat="server"></dnc:EditItemsList>
		</td>
	</tr>
</table>
