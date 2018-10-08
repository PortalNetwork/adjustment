pragma solidity ^0.4.11;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract Adjustment is usingOraclize {

   string public TPNTUSD;
   event LogConstructorInitiated(string nextStep);
   event LogPriceUpdated(string price);
   event LogNewOraclizeQuery(string description);

   function Adjustment() payable {
       LogConstructorInitiated("Constructor was initiated. Call 'updatePrice()' to send the Oraclize Query.");
   }

   function __callback(bytes32 myid, string result) {
       if (msg.sender != oraclize_cbAddress()) revert();
       TPNTUSD = result;
       LogPriceUpdated(result);
   }

   function updatePrice() payable {
       if (oraclize_getPrice("URL") > this.balance) {
           LogNewOraclizeQuery("Oraclize query was NOT sent, please add some TPNT to cover for the query fee");
       } else {
           LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer.");
           oraclize_query("URL", "json(https://api.gdax.com/products/TPNT-USD/ticker).price");
       }
   }
}
