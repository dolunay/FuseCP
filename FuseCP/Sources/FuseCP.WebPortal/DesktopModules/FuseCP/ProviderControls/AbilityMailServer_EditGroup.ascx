<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AbilityMailServer_EditGroup.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.AbilityMailServer_EditGroup" %>
<%@ Register TagPrefix="dnc" TagName="EditItemsList" Src="../MailEditItems.ascx" %>
<table class="table table-borderless align-top mb-0 w-100">
	<tr>
		<td class="SubHead text-nowrap align-top" style="width: 200px;">
		    <asp:Label ID="lblGroupMembers" runat="server" meta:resourcekey="lblGroupMembers" Text="Group e-mails:"></asp:Label>
		</td>
		<td class="normal align-top">
			<dnc:EditItemsList id="mailEditItems" runat="server"></dnc:EditItemsList>
		</td>
	</tr>
</table>
