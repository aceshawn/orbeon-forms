/**
 *  Copyright (C) 2005 Orbeon, Inc.
 *
 *  This program is free software; you can redistribute it and/or modify it under the terms of the
 *  GNU Lesser General Public License as published by the Free Software Foundation; either version
 *  2.1 of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 *  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *  See the GNU Lesser General Public License for more details.
 *
 *  The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
 */
package org.orbeon.oxf.xforms;

/**
 * XForms events definitions.
 */
public class XFormsEvents {
    // Custom initialization events
    public static final String XXFORMS_INITIALIZE = "xxforms-initialize";
    public static final String XXFORMS_INITIALIZE_CONTROLS = "xxforms-initialize-controls";

    // Standard sequences
    public static final String XXFORMS_VALUE_CHANGE_WITH_FOCUS_CHANGE = "xxforms-value-change-with-focus-change";

    // Standard XForms events
    public static final String XFORMS_MODEL_CONSTRUCT = "xforms-model-construct";
    public static final String XFORMS_MODEL_DONE = "xforms-model-construct-done";
    public static final String XFORMS_READY = "xforms-ready";
    public static final String XFORMS_MODEL_DESTRUCT = "xforms-model-destruct";
    public static final String XFORMS_REBUILD = "xforms-rebuild";
    public static final String XFORMS_RECALCULATE = "xforms-recalculate";
    public static final String XFORMS_REVALIDATE = "xforms-revalidate";
    public static final String XFORMS_REFRESH = "xforms-refresh";
    public static final String XFORMS_RESET = "xforms-reset";

    public static final String XFORMS_VALUE_CHANGED = "xforms-value-changed";

    public static final String XFORMS_DESELECT = "xforms-deselect";
    public static final String XFORMS_SELECT = "xforms-select";

    public static final String XFORMS_INSERT = "xforms-insert";
    public static final String XFORMS_DELETE = "xforms-delete";

    // DOM events
    public static final String XFORMS_DOM_ACTIVATE = "DOMActivate";
    public static final String XFORMS_DOM_FOCUS_OUT = "DOMFocusOut";
    public static final String XFORMS_DOM_FOCUS_IN = "DOMFocusIn";

    // Exceptions and errors
    public static final String XFORMS_LINK_EXCEPTION = "xforms-link-exception";
    public static final String XFORMS_LINK_ERROR = "xforms-link-error";
    public static final String XFORMS_COMPUTE_EXCEPTION = "xforms-compute-exception";

    // Standard XForms actions
    public static final String XFORMS_ACTION_ACTION = "action";

    public static final String XFORMS_DISPATCH_ACTION = "dispatch";
    public static final String XFORMS_REBUILD_ACTION = "rebuild";
    public static final String XFORMS_RECALCULATE_ACTION = "recalculate";
    public static final String XFORMS_REVALIDATE_ACTION = "revalidate";
    public static final String XFORMS_REFRESH_ACTION = "refresh";
    public static final String XFORMS_SETFOCUS_ACTION = "setfocus";
    public static final String XFORMS_LOAD_ACTION = "load";
    public static final String XFORMS_SETVALUE_ACTION = "setvalue";
    public static final String XFORMS_SEND_ACTION = "send";
    public static final String XFORMS_RESET_ACTION = "reset";
    public static final String XFORMS_MESSAGE_ACTION = "message";

    public static final String XFORMS_TOGGLE_ACTION = "toggle";
    public static final String XFORMS_INSERT_ACTION = "insert";
    public static final String XFORMS_DELETE_ACTION = "delete";
    public static final String XFORMS_SETINDEX_ACTION = "setindex";
}
