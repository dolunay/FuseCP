<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserAccountChangePassword.ascx.cs"
    Inherits="FuseCP.Portal.UserAccountChangePassword" %>
<%@ Register Src="UserControls/PasswordControl.ascx" TagName="PasswordControl" TagPrefix="fcp" %>
<asp:Panel ID="PasswordPanel" runat="server" DefaultButton="cmdChangePassword">
    <div class="card-body form-horizontal">
        <table cellspacing="0" cellpadding="2" width="100%">
            <tr>
                <td class="col-sm-2 form-label">
                    <asp:Label ID="lblUsername2" runat="server" meta:resourcekey="lblUsername" Text="Username:"></asp:Label>
                </td>
                <td>
                    <strong><asp:Literal ID="lblUsername" runat="server"></asp:Literal></strong>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <fcp:PasswordControl ID="userPassword" runat="server" />
                </td>
            </tr>
            <tr id="trChangePasswordWarning" runat="server" visible="false">
                <td>
                </td>
                <td>
                    <asp:Label ID="lblChangePasswordWarning" runat="server" CssClass="ErrorText">Warning: This will end the current session.</asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div class="card-footer text-end">
        <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
        <asp:LinkButton id="cmdChangePassword" CssClass="btn btn-success" runat="server" OnClick="cmdChangePassword_Click" ValidationGroup="NewPassword"> <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="cmdChangePassword"/> </asp:LinkButton>
    </div>
</asp:Panel>
