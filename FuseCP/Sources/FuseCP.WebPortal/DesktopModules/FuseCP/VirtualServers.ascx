<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VirtualServers.ascx.cs" Inherits="FuseCP.Portal.VirtualServers" %>
<%@ Import Namespace="FuseCP.Portal" %>
<div class="buttons-in-panel-header">
    <asp:LinkButton ID="btnAddItem"  runat="server" CssClass="btn btn-primary" OnClick="btnAddItem_Click">
        <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddItem" />
    </asp:LinkButton>
</div>
<section>
    <div class="card-body">
    <asp:Repeater ID="dlServers" Runat="server">
        <ItemTemplate>
            <div class="col-sm-12 col-md-6 col-lg-4">
                <div class="card border-info server-panel matchHeight">
                    <div class="card-header" style="min-height:43px;padding: 10px 0px;">
                        <div class="col-sm-8">
                            <h3 class="card-title" style="line-height:inherit;white-space:nowrap;overflow:hidden;" title="<%# PortalAntiXSS.EncodeOld((string)Eval("ServerName")) %>">
                                <i class="bi bi-server" aria-hidden="true">&nbsp;</i>&nbsp;
                                <%# PortalAntiXSS.EncodeOld((string)Eval("ServerName")) %>
                            </h3>
                        </div>
                        <div class="col-sm-4 text-end">
                            <asp:hyperlink id=lnkEdit runat="server" CssClass="btn btn-secondary btn-sm" style="margin-top:-4px; margin-left: -18px;" NavigateUrl='<%# EditUrl("ServerID", Eval("ServerID").ToString(), "edit_server") %>'>
                                <i class="bi bi-cogs" aria-hidden="true">&nbsp;</i>&nbsp;Settings
                            </asp:hyperlink>
                        </div>
                    </div>
                    <ul class="list-group">
                        <li class="list-group-item">
                            <%# PortalAntiXSS.EncodeOld((string)Eval("Comments")) %>
                        </li>
                        <li class="list-group-item">
                            <%# Eval("ServicesNumber") %>
                            <asp:Localize ID="locServices" runat="server" meta:resourcekey="locServices" Text="services" />
                        </li>
                    </ul>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    </div>
</section>
<table id="tblEmptyList" runat="server" class="table table-borderless mb-0 w-100">
    <tr>
        <td class="Normal text-center">
            <asp:Label ID="lblEmptyList" runat="server" meta:resourcekey="lblEmptyList" Text="Empty list..."></asp:Label>
        </td>
    </tr>
</table>
<div class="card-footer text-end">
    <asp:LinkButton ID="StyleButton1"  runat="server" CssClass="btn btn-primary" OnClick="btnAddItem_Click">
        <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddItem" />
    </asp:LinkButton>
</div>
