<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ArgoMail_EditList.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.ArgoMail_EditList" %>
<%@ Register TagPrefix="dnc" TagName="EditItemsList" Src="../MailEditItems.ascx" %>
<table class="table table-borderless align-middle mb-0 w-100">
	<tr>
		<td class="SubHead text-nowrap" >
		    <asp:Label ID="lblReplyTo" runat="server" meta:resourcekey="lblReplyTo" Text="Subscribers reply to:"></asp:Label>
		</td>
		<td class="normal">
			<asp:DropDownList id="ddlReplyTo" runat="server" resourcekey="ddlReplyTo" CssClass="form-control" Width="150px">
				<asp:ListItem Value="RepliesToList">List</asp:ListItem>
				<asp:ListItem Value="RepliesToSender">Sender</asp:ListItem>
			</asp:DropDownList>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="SubHead">
		    <asp:Label ID="lblPostingMode" runat="server" meta:resourcekey="lblPostingMode" Text="Posting mode:"></asp:Label>
		</td>
		<td class="normal">
			<asp:DropDownList id="ddlPostingMode" runat="server" resourcekey="ddlPostingMode" CssClass="form-control" Width="150px">
				<asp:ListItem Value="MembersCanPost">MembersOnly</asp:ListItem>
				<asp:ListItem Value="AnyoneCanPost">Anyone</asp:ListItem>
			</asp:DropDownList>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="SubHead align-top">
		    <asp:Label ID="lblMembers" runat="server" meta:resourcekey="lblMembers" Text="Mailing list members:"></asp:Label>
		</td>
		<td class="align-top">
			<dnc:EditItemsList id="mailEditItems" runat="server"></dnc:EditItemsList>
		</td>
	</tr>
</table>
