using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entity.ViewModels;
namespace Interfaces.Data
{
    public interface IProposalDataService
    {
        List<ProposalDetailsVM> GetProposalList(ProposalDetailsVM ObjProposalDetailsVM);

        Response AddProposal(ProposalDetailsVM ObjProposalDetailsVM);

        Response UpdateProposal(ProposalDetailsVM ObjProposalDetailsVM);

        Response DeleteProposal(ProposalDetailsVM ObjProposalDetailsVM);
    }
}
