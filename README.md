# Student Attendance Smart Contract

## Contract Details

**Contract Address:** `0xDf3bb2e5A096ef16e39CD2702d34a83D6D351070`

**Network:** CoreDao Testnet (Chain ID: 1115)

**Explorer:** https://scan.test2.btcs.network/address/0xDf3bb2e5A096ef16e39CD2702d34a83D6D351070

## Functions

### Write Functions
- `addStudent(string _name, uint8 _age)` - Add a new student
- `updateAttendance(uint256 _studentId, bool _present)` - Update attendance status

### Read Functions
- `getTotalStudents()` - Get total number of students
- `getStudent(uint256 _studentId)` - Get student details (name, age, present)
- `students(uint256)` - Access student array directly

## Events
- `StudentAdded(uint256 indexed studentId, string name, uint8 age)`
- `AttendanceUpdated(uint256 indexed studentId, bool present)`

## Network Info
- RPC: https://rpc.test2.btcs.network
- Faucet: https://scan.test2.btcs.network/faucet