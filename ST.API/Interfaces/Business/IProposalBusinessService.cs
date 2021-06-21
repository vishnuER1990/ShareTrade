using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Interfaces.Business;
using Interfaces.Data;
using Entity;
using Entity.ViewModels;

namespace Interfaces.Business
{
    public interface IProposalBusinessService
    {
        List<ProposalDetailsVM> GetProposalList(ProposalDetailsVM ObjProposalDetailsVM);

        Response AddProposal(ProposalDetailsVM ObjProposalDetailsVM);

        Response UpdateProposal(ProposalDetailsVM ObjProposalDetailsVM);

        Response DeleteProposal(ProposalDetailsVM ObjProposalDetailsVM);
    }
}
