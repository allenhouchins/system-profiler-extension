# System Profiler Osquery Extension (Go)

A Go-based osquery extension that provides macOS system profiler information as a native table. This extension allows you to query system hardware and software information using SQL.

## Table Schema

| Column      | Type   | Description                    |
|-------------|--------|--------------------------------|
| section     | TEXT   | Main section (e.g., "Hardware", "Software") |
| subsection  | TEXT   | Subsection within the main section |
| key         | TEXT   | Property name                  |
| value       | TEXT   | Property value                 |
| data_type   | TEXT   | System Profiler data type (e.g., "SPHardwareDataType") |

## Building the Extension

1. Clone the repository
2. Install dependencies:
   ```bash
   go mod tidy
   ```
3. Build the extension:
   ```bash
   make build
   ```
   or manually:
   ```bash
   go build -o system_profiler.ext
   ```

## Usage

### With Fleet
```bash
sudo orbit shell -- --extension system_profiler.ext --allow-unsafe
```

### With standard osquery
```bash
osqueryi --extension=/path/to/system_profiler.ext
```

### Example Queries

```sql
-- Get all system profiler information
SELECT * FROM system_profiler;

-- Get hardware information
SELECT * FROM system_profiler WHERE section = 'Hardware';

-- Get software information
SELECT * FROM system_profiler WHERE section = 'Software';

-- Get specific hardware details
SELECT * FROM system_profiler 
WHERE section = 'Hardware' 
AND subsection = 'Hardware Overview';

-- Find model information
SELECT * FROM system_profiler 
WHERE key LIKE '%Model%';

-- Get memory information
SELECT * FROM system_profiler 
WHERE section = 'Memory';

-- Get network interface information
SELECT * FROM system_profiler 
WHERE section = 'Network';

-- Get storage information
SELECT * FROM system_profiler 
WHERE section = 'NVMExpress';

-- Get graphics information
SELECT * FROM system_profiler 
WHERE section = 'Graphics/Displays';

-- Get USB device information
SELECT * FROM system_profiler 
WHERE section = 'USB';

-- Get Bluetooth information
SELECT * FROM system_profiler 
WHERE section = 'Bluetooth';

-- Get Wi-Fi information
SELECT * FROM system_profiler 
WHERE section = 'Wi-Fi';

-- Get printer information
SELECT * FROM system_profiler 
WHERE section = 'Printers';

-- Get camera information
SELECT * FROM system_profiler 
WHERE section = 'Camera';

-- Get audio device information
SELECT * FROM system_profiler 
WHERE section = 'Audio';

-- Get Thunderbolt/USB4 information
SELECT * FROM system_profiler 
WHERE section = 'Thunderbolt/USB4';

-- Get Apple Pay information
SELECT * FROM system_profiler 
WHERE section = 'Apple Pay';

-- Get controller information
SELECT * FROM system_profiler 
WHERE section = 'Controller';

-- Get SPI information
SELECT * FROM system_profiler 
WHERE section = 'SPI';

-- Get printer software information
SELECT * FROM system_profiler 
WHERE section = 'Printer Software';

-- Get firewall information
SELECT * FROM system_profiler 
WHERE section = 'Firewall';

-- Get language and region settings
SELECT * FROM system_profiler 
WHERE section = 'Language & Region';

-- Get location services information
SELECT * FROM system_profiler 
WHERE section = 'Locations';

-- Get power management information
SELECT * FROM system_profiler 
WHERE section = 'Power';

-- Get storage information
SELECT * FROM system_profiler 
WHERE section = 'Storage';

-- Get volume information
SELECT * FROM system_profiler 
WHERE section = 'Volumes';

-- Query by data type examples
-- Get all hardware information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPHardwareDataType';

-- Get all network information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPNetworkDataType';

-- Get all software information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPSoftwareDataType';

-- Get all storage information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPStorageDataType';

-- Get all power management information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPPowerDataType';

-- Get all firewall settings using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPFirewallDataType';

-- Get all Bluetooth information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPBluetoothDataType';

-- Get all Wi-Fi information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPAirPortDataType';

-- Get all USB device information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPUSBDataType';

-- Get all Thunderbolt/USB4 information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPThunderboltDataType';

-- Get all audio device information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPAudioDataType';

-- Get all camera information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPCameraDataType';

-- Get all printer information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPPrintersDataType';

-- Get all memory information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPMemoryDataType';

-- Get all NVMExpress storage information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPNVMeDataType';

-- Get all language and region settings using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPInternationalDataType';

-- Get all location services information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPNetworkLocationDataType';

-- Get all SPI information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPSPIDataType';

-- Get all Apple Pay information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPSecureElementDataType';

-- Get all printer software information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPPrintersSoftwareDataType';

-- Get all volume information using data type
SELECT * FROM system_profiler 
WHERE data_type = 'SPNetworkVolumeDataType';
```

## Data Structure

The extension parses the output of `/usr/sbin/system_profiler -detailLevel basic` and organizes it into a structured table format. The data is hierarchical with:

- **Sections**: Main categories like "Hardware", "Software", "Network", etc.
- **Subsections**: Subcategories within sections (e.g., "Hardware Overview" within "Hardware")
- **Key-Value Pairs**: Individual properties and their values
- **Data Types**: System Profiler data types that correspond to specific sections of information

## Data Types

The `data_type` column contains the System Profiler data type for each row. These data types correspond to the available data types that can be queried individually using `system_profiler -listDataTypes`. The mapping includes:

- **SPHardwareDataType**: Hardware information
- **SPSoftwareDataType**: Software information
- **SPNetworkDataType**: Network interfaces and configurations
- **SPStorageDataType**: Storage devices and volumes
- **SPDisplaysDataType**: Graphics and displays
- **SPUSBDataType**: USB devices
- **SPBluetoothDataType**: Bluetooth devices and connections
- **SPAirPortDataType**: Wi-Fi information and network details
- **SPPrintersDataType**: Printers and peripherals
- **SPAudioDataType**: Audio devices
- **SPCameraDataType**: Camera devices
- **SPThunderboltDataType**: Thunderbolt/USB4 ports
- **SPFirewallDataType**: Firewall settings and applications
- **SPInternationalDataType**: Language and region settings
- **SPNetworkLocationDataType**: Location services and network configurations
- **SPPowerDataType**: Power management and battery information
- **SPMemoryDataType**: Memory information
- **SPNVMeDataType**: NVMExpress storage information
- **SPSPIDataType**: SPI information
- **SPSecureElementDataType**: Apple Pay information
- **SPPrintersSoftwareDataType**: Printer software information
- **SPNetworkVolumeDataType**: Volume information

You can query by data type to get all information related to a specific category, regardless of the section name.

## Requirements

- Go 1.21 or later
- macOS system (extension only works on macOS)
- osquery or Fleet

## Platform Compatibility

This extension is designed specifically for macOS and will return empty results on other platforms. The extension checks the operating system at runtime and only executes the `system_profiler` command on macOS systems.

## Data Source

The extension uses the macOS `system_profiler` command with the `-detailLevel basic` flag to gather system information. The `basic` detail level provides more comprehensive information compared to `mini`, including additional sections like firewall settings, power management, storage volumes, and network configurations. This provides a comprehensive overview of:

- Hardware specifications
- Software versions
- Network interfaces and configurations
- Storage devices and volumes
- Graphics and displays
- USB devices
- Bluetooth devices and connections
- Wi-Fi information and network details
- Printers and peripherals
- Audio devices
- Camera devices
- Thunderbolt/USB4 ports
- Firewall settings and applications
- Language and region settings
- Location services and network configurations
- Power management and battery information
- Storage volumes and file systems
- And more...

## Structure

```
├── main.go              # Main extension code
├── go.mod               # Go module definition
├── Makefile             # Build configuration
└── README.md            # This file
```

## License

Same as the parent project. 