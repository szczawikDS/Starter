{
  Starter
  Copyright (C) 2019-2020 Damian Skrzek (szczawik)

  This file is part of Starter.

  Starter is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 3 of the License, or
  (at your option) any later version.

  Starter is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Starter.  If not, see <http://www.gnu.org/licenses/>.
}

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
    ptMinus,
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

