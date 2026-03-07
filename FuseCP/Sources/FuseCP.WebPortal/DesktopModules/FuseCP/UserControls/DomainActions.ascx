<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DomainActions.ascx.cs" Inherits="FuseCP.Portal.DomainActions" %>
<script type="text/javascript" src="/DesktopModules/FuseCP/Scripts/bulk-action-progress.js"></script>
<asp:UpdatePanel ID="tblActions" runat="server" CssClass="NormalBold" UpdateMode="Conditional" ChildrenAsTriggers="true" >
    <ContentTemplate>
        <div class="input-group">
        <asp:DropDownList ID="ddlDomainActions" runat="server" CssClass="form-control" resourcekey="ddlDomainActions" AutoPostBack="True">
            <asp:ListItem Value="0">Actions</asp:ListItem>
            <asp:ListItem Value="1">EnableDns</asp:ListItem>
            <asp:ListItem Value="2">DisableDns</asp:ListItem>
            <asp:ListItem Value="3">CreatePreviewDomain</asp:ListItem>
            <asp:ListItem Value="4">DeletePreviewDomain</asp:ListItem>
        </asp:DropDownList>
         <div class="d-flex">
             <asp:LinkButton id="btnApply" CssClass="btn btn-primary" runat="server" OnClick="btnApply_Click" OnClientClick="return ShowDomainActionProgress(this);"><asp:Label runat="server" meta:resourcekey="btnApplyText"/></asp:LinkButton>
         </div>
       </div>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="btnApply" />
    </Triggers>
</asp:UpdatePanel>
