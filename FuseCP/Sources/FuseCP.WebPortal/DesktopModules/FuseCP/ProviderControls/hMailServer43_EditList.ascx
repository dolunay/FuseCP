<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="hMailServer43_EditList.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.hMailServer43_EditList" %>
<%@ Register TagPrefix="dnc" TagName="EditItemsList" Src="../MailEditItems.ascx" %>
<%@ Register Src="../UserControls/EmailControl.ascx" TagName="EmailControl" TagPrefix="uc2" %>
<%@ Register TagPrefix="fcp" TagName="CollapsiblePanel" Src="../UserControls/CollapsiblePanel.ascx" %>


<table class="table table-borderless align-middle mb-0 w-100">
	<tr>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td class="SubHead">
		    <asp:Label ID="lblPostingMode" runat="server" meta:resourcekey="lblPostingMode" Text="Posting mode:"></asp:Label>
		</td>
		<td class="normal">
			<asp:DropDownList id="ddlPostingMode" runat="server" resourcekey="ddlPostingMode" CssClass="form-control" Width="150px" AutoPostBack="True" OnSelectedIndexChanged="ddlPostingMode_SelectedIndexChanged">
				<asp:ListItem Value="MembersCanPost">MemberShip</asp:ListItem>
				<asp:ListItem Value="AnyoneCanPost">Public</asp:ListItem>
                <asp:ListItem Value="ModeratorCanPost">Announcements</asp:ListItem>
			</asp:DropDownList>
		</td>
	<tr>
            <td class="SubHead">
                    <asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmail" Text="Announcements E-mail:" Visible = "false"></asp:Label>
                </td>
                <td class="NormalBold">
                    <uc2:EmailControl id="txtEmailAnnouncements" runat="server" Visible = "false">
                    </uc2:EmailControl>
                </td>
        </tr>
	</tr>
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
<fcp:collapsiblepanel id="Security" runat="server" targetcontrolid="pSecurity"
    meta:resourcekey="Security" Text="Security"></fcp:collapsiblepanel>
<asp:Panel runat="server" ID="pSecurity">
        <asp:CheckBox runat="server" ID="cbSMTPAuthentication"/>
        <asp:Label ID="Label1" runat="server" meta:resourcekey="lblSMTPAuthentication" Text="Require SMTP Authentication"/>
</asp:Panel>
