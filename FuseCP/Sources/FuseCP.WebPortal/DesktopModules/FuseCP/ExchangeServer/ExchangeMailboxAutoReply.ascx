<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ExchangeMailboxAutoReply.ascx.cs" Inherits="FuseCP.Portal.ExchangeServer.ExchangeMailboxAutoReply" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>
<%@ Register Src="UserControls/MailboxTabs.ascx" TagName="MailboxTabs" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/ItemButtonPanel.ascx" TagName="ItemButtonPanel" TagPrefix="fcp" %>
<script src='/tinymce/tinymce.min.js'></script>

<fcp:EnableAsyncTasksSupport ID="asyncTasks" runat="server" />

<script src='/DesktopModules/FuseCP/Scripts/exchange-mailbox-autoreply.js'></script>

<div class="card-header">
    <h3 class="card-title">
        <asp:Image ID="Image2" SkinID="ExchangeMailbox48" runat="server" />
        <asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Edit Auto Reply"></asp:Localize>
        -
		<asp:Literal ID="litDisplayName" runat="server" Text="" />
    </h3>
</div>
<div class="card-body form-horizontal fcp-modern-page">
    <fcp:MailboxTabs ID="MailboxTabs" runat="server" SelectedTab="mailbox_autoreply" />
    <div class="card tab-content">
        <fcp:SimpleMessageBox ID="messageBox" runat="server" />
        <div class="row mb-3">
            <div class="col-sm-10 d-flex flex-wrap gap-2 align-items-center">
                <table >
                    <tr>
                        <td>
                            <asp:RadioButtonList ID="rblSetAutoreply" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblSetAutoreply_SelectedIndexChanged">
                                <asp:ListItem Text="Don't send automatic replies" meta:resourcekey="rblSetAutoreplyOff" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Send automatic replies" meta:resourcekey="rblSetAutoreplyOn"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="fcp-ps-15">
                            <asp:CheckBox ID="chkAutoReplyTime" runat="server" meta:resourcekey="chkAutoReplyTime" Text="Send replies only during this time period:" AutoPostBack="true" OnCheckedChanged="chkAutoReplyTime_CheckedChanged" />
                        </td>
                    </tr>
                    <tr>
                        <td class="fcp-ps-30 fcp-pb-5 fcp-pt-5">
                            <asp:Label ID="locStartTime" runat="server" meta:resourcekey="locStartTime" Text="Start time:"></asp:Label>
                            <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
                            <asp:TextBox ID="txtStartTime" runat="server" TextMode="Time"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="fcp-ps-30 fcp-pb-10 fcp-pt-5">
                            <asp:Label ID="locEndTime" runat="server" meta:resourcekey="locEndTime" Text="End time:"></asp:Label>
                            <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
                            <asp:TextBox ID="txtEndTime" runat="server" TextMode="Time"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="fcp-ps-15">
                            <asp:Localize ID="locIntReply" runat="server" meta:resourcekey="locIntReply" Text="Send a reply once to each sender inside my organization with the following message:"></asp:Localize>
                        </td>
                    </tr>
                    <tr>
                        <td class="fcp-ps-15">
                            <asp:TextBox ID="txtIntReply" runat="server" CssClass="tinymce" Rows="15" cols="20" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="fcp-ps-15 fcp-pt-20">
                            <asp:CheckBox ID="chkOutsideOrganization" runat="server" meta:resourcekey="chkOutsideOrganization" Text="Send replies outside my organization" AutoPostBack="true" OnCheckedChanged="chkOutsideOrganization_CheckedChanged" />
                        </td>
                    </tr>
                    <tr>
                        <td class="fcp-ps-30 fcp-pb-10">
                            <asp:RadioButtonList ID="rblExternalAudience" runat="server" AutoPostBack="False">
                                <asp:ListItem Text="Only to senders in my Contact list" meta:resourcekey="rblExtContact"></asp:ListItem>
                                <asp:ListItem Text="Send to all external senders" meta:resourcekey="rblExtAll" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="fcp-ps-30">
                            <asp:Localize ID="locExtReply" runat="server" meta:resourcekey="locExtReply" Text="Send a reply once to each sender outside my organization with the following message:"></asp:Localize>
                        </td>
                    </tr>
                    <tr>
                        <td class="fcp-ps-30">
                            <asp:TextBox ID="txtExtReply" runat="server" CssClass="tinymce" Rows="15" cols="20" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="card-footer text-end">
    <fcp:ItemButtonPanel ID="buttonPanel" runat="server" ValidationGroup="EditMailbox"
        OnSaveClick="btnSave_Click" OnSaveExitClick="btnSaveExit_Click" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="EditMailbox" />
</div>
