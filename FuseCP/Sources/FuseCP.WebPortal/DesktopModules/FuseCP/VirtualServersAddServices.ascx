<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VirtualServersAddServices.ascx.cs" Inherits="FuseCP.Portal.VirtualServersAddServices" %>
<div class="FormButtonsBar">
    <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnAdd" CssClass="btn btn-success" runat="server" OnClick="btnAdd_Click"> <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAdd"/> </asp:LinkButton>
</div>
<div class="card-body form-horizontal">
    <asp:DataList ID="dlServers" Runat="server" RepeatColumns="3" RepeatDirection="Horizontal" CellSpacing="15">
	    <ItemStyle Height="120px" VerticalAlign="Top"></ItemStyle>
	    <ItemTemplate>
            <div class="col-sm-12">
                <div class=" card border-info server-panel matchHeight">
                    <div class="card-header">
                        <h3 class="card-title" style="line-height:inherit;white-space:nowrap;overflow:hidden;" title="<%# Eval("ServerName") %>">
                            <i class="bi bi-server" aria-hidden="true">&nbsp;</i>&nbsp;
                            <%# Eval("ServerName") %>
                        </h3>
                    </div>
                    <ul class="list-group">
                        <li class="list-group-item">
                            <%# Eval("Comments") %>
                        </li>
                        <li class="list-group-item">
						    <asp:DataList ID="dlServices" Runat="server" DataSource='<%# GetServerServices((int)Eval("ServerID")) %>'
						    CellPadding="1" CellSpacing="1" Width="50%" DataKeyField="ServiceID">
							    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
							    <ItemTemplate>
				                     <asp:CheckBox ID="chkSelected" runat="server" Text='<%# Eval("ServiceName") %>' Width="100%" />
							    </ItemTemplate>
						    </asp:DataList>
                        </li>
                    </ul>
                </div>
            </div>
	    </ItemTemplate>
    </asp:DataList>
</div>
