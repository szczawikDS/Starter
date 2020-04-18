{---------------------------------------------------------------------------
Based on mwPasLexTypes, written by Martin Waldenburg.
----------------------------------------------------------------------------}

unit CastaliaPasLexTypes;

interface

uses SysUtils;

type

  TTokenPoint = packed record
    X : Integer;
    Y : Integer;
  end;

  TptTokenKind = (
    ptComma,
	  ptCRLF,
    ptEqual,
    ptError,
    ptFloat,
    ptIdentifier,
    ptInteger,
    ptNull,
    ptSlash,
    ptSlashesComment,
    ptSpace,
    ptSquareClose,
    ptSquareOpen,
    ptStar,
    ptSymbol,
    ptUnknown);

TmwPasLexStatus = record
  LineNumber: Integer;
  LinePos: Integer;
  Origin: PChar;
  RunPos: Integer;
  TokenPos: Integer;
  TokenID: TptTokenKind;
end;

function IsTokenIDJunk(const aTokenID : TptTokenKind ) :Boolean;

implementation

function IsTokenIDJunk(const aTokenID : TptTokenKind ) :boolean;
begin
  Result := aTokenID in [ptCRLF, ptSlashesComment, ptSpace];
end;


end.

