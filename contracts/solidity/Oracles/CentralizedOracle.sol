pragma solidity 0.4.11;
import "Oracles/AbstractOracle.sol";


/// @title Centralized oracle contract - Allows the contract owner to set an outcome
/// @author Stefan George - <stefan@gnosis.pm>
contract CentralizedOracle is Oracle {

    /*
     *  Storage
     */
    address public owner;
    bytes public ipfsHash;
    bool public isSet;
    int public outcome;

    /*
     *  Modifiers
     */
    modifier isOwner () {
        // Only owner is allowed to proceed
        require(msg.sender == owner);
        _;
    }

    /*
     *  Public functions
     */
    /// @dev Constructor sets owner address and IPFS hash
    /// @param _ipfsHash Hash identifying off chain event description
    function CentralizedOracle(address _owner, bytes _ipfsHash)
        public
    {
        // Description hash cannot be null
        require(_ipfsHash.length == 46);
        owner = _owner;
        ipfsHash = _ipfsHash;
    }

    /// @dev Replaces owner
    /// @param _owner New owner
    function replaceOwner(address _owner)
        public
        isOwner
    {
        // Result is not set yet
        require(!isSet);
        owner = _owner;
    }

    /// @dev Sets event outcome
    /// @param _outcome Event outcome
    function setOutcome(int _outcome)
        public
        isOwner
    {
        // Result is not set yet
        require(!isSet);
        isSet = true;
        outcome = _outcome;
    }

    /// @dev Returns if winning outcome is set
    /// @return Is outcome set?
    function isOutcomeSet()
        public
        constant
        returns (bool)
    {
        return isSet;
    }

    /// @dev Returns outcome
    /// @return Outcome
    function getOutcome()
        public
        constant
        returns (int)
    {
        return outcome;
    }
}
