using Microsoft.Owin.Security.OAuth;
using System;
using System.Security.Claims;
using System.Threading.Tasks;

namespace ST.API
{
    public class AuthorizationServerProvider : OAuthAuthorizationServerProvider
    {
        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            context.Validated();
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            UserAuthentication OBJ = new UserAuthentication();

            try
            {

                var user = OBJ.ValidateUser(context.UserName, context.Password);
                if (user == "false")
                {
                    context.SetError("error", "Username or password is incorrect");
                    return;
                }
                else if (user == "AdminApprovalPending")
                {
                    context.SetError("error", "Admin approval is pending. Please contact Admin.");
                    return;
                }
                var claims = OBJ.GetUserRoleClaim(context.UserName, context.Password);

                var identity = new ClaimsIdentity(context.Options.AuthenticationType);
                identity.AddClaim(new Claim(ClaimTypes.Role, claims.IsAdmin ? "Admin" : "NormalUser"));
                identity.AddClaim(new Claim(ClaimTypes.Sid, claims.UserId.ToString()));

                context.Validated(identity);
            }
            catch(Exception ex)
            {
                context.SetError("error", OBJ.AddError(ex, 0));
                return; 
            }
            finally
            {
                OBJ.Dispose();
            }
        }
    }
}