<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SignedInUser.ascx.cs" Inherits="FuseCP.Portal.SkinControls.SignedInUser" %>

<asp:Panel ID="AnonymousPanel" runat="server">
	<asp:HyperLink ID="lnkSignIn" runat="server" meta:resourcekey="lnkSignIn">Sign In</asp:HyperLink>
</asp:Panel>


<asp:Panel ID="LoggedPanel" runat="server">

    <ul class="nav navbar-nav navbar-right d-none d-sm-block">
    <li>
    <asp:HyperLink ID="lnkEditUserDetails" runat="server">
        <i class="bi bi-person"></i>&nbsp;
        <span class="d-none d-sm-block d-sm-none d-md-block"><asp:Localize runat="server" meta:resourcekey="lnkEditUserDetails" /></span>
    </asp:HyperLink>
    </li>
    <li>
    <asp:LinkButton ID="cmdSignOut" runat="server" CausesValidation="false" OnClick="cmdSignOut_Click">
        <i class="bi bi-box-arrow-right "></i>
        <asp:Localize runat="server" meta:resourcekey="cmdSignOut" />
    </asp:LinkButton>
    </li>
        </ul>
</asp:Panel>


<asp:Panel ID="LoggedPanelSm" runat="server" CssClass="d-block d-sm-none-block">
    <ul class="nav navbar-sm navbar-right">
    <li>
     <a href="#" class="show-search">
        <i class="bi bi-search fa-2x">&nbsp;</i>
     </a>
    </li>
    <li>
    <asp:HyperLink ID="lnkEditUserDetailsSm" runat="server"><span><i class="bi bi-person fa-2x">&nbsp;</i></span>
    </asp:HyperLink>
    </li>
    <li>
    <asp:LinkButton ID="cmdSignOutSm" runat="server" CausesValidation="false" OnClick="cmdSignOut_Click">
        <i class="bi bi-box-arrow-right fa-2x"></i>
    </asp:LinkButton>
    </li>
        </ul>
</asp:Panel>