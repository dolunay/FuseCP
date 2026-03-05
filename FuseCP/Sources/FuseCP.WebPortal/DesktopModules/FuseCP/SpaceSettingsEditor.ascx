<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpaceSettingsEditor.ascx.cs" Inherits="FuseCP.Portal.SpaceSettingsEditor" %>
<div class="card-body form-horizontal">
    <asp:UpdatePanel runat="server" ID="updatePanelUsers">
        <ContentTemplate>
        
            <asp:DropDownList ID="ddlOverride" runat="server" CssClass="form-control"
                    resourcekey="ddlOverride" AutoPostBack="true" OnSelectedIndexChanged="ddlOverride_SelectedIndexChanged">
                <asp:ListItem>UseHost</asp:ListItem>
                <asp:ListItem>OverrideHost</asp:ListItem>
            </asp:DropDownList>
            
            <br />
            <br />
            <asp:PlaceHolder ID="settingsPlace" runat="server"></asp:PlaceHolder>
            
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<div class="card-footer text-end">
    <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnSave" CssClass="btn btn-success" runat="server" OnClick="btnSave_Click" ValidationGroup="SettingsEditor"> <i class="bi bi-floppy">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnSave"/> </asp:LinkButton>
</div>
