export class SaleDetailsVM
{
    SaleId: number;
    ShareDetailsId: number;
    ProposalId: number;
    NumberOfShares: number;
    AvailableShares: number;
    UnitPrice: number;
    SaleRemarks: string;
    ShareDescription :string;
    CreatedDt: Date;
    CreatedBy: number;
    UpdatedDt: Date;
    UpdatedBy: number;
    Status: number;
    StatusComments: string;
    IsActive: boolean;
    CreatedBy_String: string;
    UpdatedBy_String:string;
    BidCount: number;
    IsNegotiable: boolean;
    ShareholderContactNumber: string;
    ValidTo: Date;
}