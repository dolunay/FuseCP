<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AbilityMailServer_EditList.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.AbilityMailServer_EditList" %>
<%@ Register TagPrefix="dnc" TagName="EditItemsList" Src="../MailEditItems.ascx" %>
<table class="table table-borderless align-top mb-0 w-100">
	<tr>
		<td class="SubHead align-top">
		    <asp:Label ID="lblMembers" runat="server" meta:resourcekey="lblMembers" Text="Mailing list members:"></asp:Label>
		</td>
		<td class="align-top">
			<dnc:EditItemsList id="mailEditItems" runat="server"></dnc:EditItemsList>
		</td>
	</tr>
</table>
