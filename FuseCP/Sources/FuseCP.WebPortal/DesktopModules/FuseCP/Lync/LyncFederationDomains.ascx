<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LyncFederationDomains.ascx.cs" Inherits="FuseCP.Portal.Lync.LyncFederationDomains" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/QuotaViewer.ascx" TagName="QuotaViewer" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>

<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server"/>

			<div class="card-header">
                    <h3 class="card-title">
					<asp:Image ID="Image1" SkinID="LyncFederationDomains48" runat="server" />
					<asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Domain Names"></asp:Localize>
				</h3>
                        </div>
				<div class="card-body form-horizontal">
				    <fcp:SimpleMessageBox id="messageBox" runat="server" />
				    
                    <div class="FormButtonsBarClean">
                        <asp:LinkButton id="btnAddDomain" CssClass="btn btn-success" runat="server" OnClick="btnAddDomain_Click"> <i class="bi bi-globe">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddDomainText"/> </asp:LinkButton>
                    </div>

				    <asp:GridView ID="gvDomains" runat="server" AutoGenerateColumns="False" EnableViewState="true"
					    Width="100%" EmptyDataText="gvDomains" CssSelectorClass="NormalGridView" OnRowCommand="gvDomains_RowCommand">
					    <Columns>
						    <asp:TemplateField HeaderText="gvDomainsName">
							    <ItemStyle Width="70%"></ItemStyle>
							    <ItemTemplate>
								    <asp:hyperlink id="lnkEditZone" runat="server" EnableViewState="false">
									    <%# Eval("DomainName") %>
								    </asp:hyperlink>
							    </ItemTemplate>
						    </asp:TemplateField>
						    <asp:TemplateField>
							    <ItemTemplate>
									<asp:LinkButton id="imgDelDomain" CssClass="btn btn-danger" runat="server" CommandName="DeleteItem" CommandArgument='<%# Eval("DomainName") %>' OnClientClick="return confirm('Are you sure you want to delete selected domain?')"> &nbsp;<i class="bi bi-trash"></i>&nbsp; </asp:LinkButton>
							    </ItemTemplate>
						    </asp:TemplateField>
					    </Columns>
				    </asp:GridView>
				    <br />
                    
				    <br />
				    
				</div>
