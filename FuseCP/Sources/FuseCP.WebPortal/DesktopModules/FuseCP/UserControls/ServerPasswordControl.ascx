<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServerPasswordControl.ascx.cs" Inherits="FuseCP.Portal.ServerPasswordControl" %>
<script src="/DesktopModules/FuseCP/Scripts/password-visibility.js" type="text/javascript"></script>
<div class="mb-3">
    <asp:TextBox ID="txtPassword" runat="server" CssClass="hideContentOnBlur form-control" type="password" TextMode="Password" MaxLength="50"></asp:TextBox>
    <asp:RequiredFieldValidator ID="valRequirePassword" runat="server" meta:resourcekey="valRequirePassword" ErrorMessage="*" ControlToValidate="txtPassword" SetFocusOnError="True"></asp:RequiredFieldValidator>
</div>
