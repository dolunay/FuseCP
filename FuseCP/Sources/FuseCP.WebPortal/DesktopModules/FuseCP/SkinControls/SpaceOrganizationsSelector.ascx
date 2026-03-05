<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpaceOrganizationsSelector.ascx.cs" Inherits="FuseCP.Portal.SkinControls.SpaceOrganizationsSelector" %>
<div class="col-4">
    <div id="spanOrgsSelector" class="OrgsSelector" runat="server" >
    <div class="input-group col-12">
            <asp:DropDownList ID="ddlSpaceOrgs" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlSpaceOrgs_SelectedIndexChanged" EnableViewState="true" AutoPostBack="true">
            </asp:DropDownList>
        <span class="d-flex">
            <asp:HyperLink ID="lnkOrgnsList" runat="server" CssClass="btn btn-primary"><i class="bi bi-pencil">&nbsp</i>&nbsp;Edit</asp:HyperLink>
        </span>
    </div>
    </div>
</div>