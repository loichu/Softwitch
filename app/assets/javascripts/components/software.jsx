window.Software = React.createClass({
    getInitialState () {
        return {
            currentVersion: undefined,
            versions: []
        }
    },
    componentDidMount() {
        this.updateVersionsAjax();
    },
    updateVersionsAjax() {
        let software_id = this.props.software.id;
        var self = this;
        $.ajax({
            method: "GET",
            url: "/softwares/" + software_id + "/versions.json",
            success(versions) {
                self.setState({versions: versions});
            }
        });
    },
    render() {
        let software = this.props.software,
            editor = this.props.editor,
            links = this.props.links;
        return <div className="container-fluid">
            <a className="btn btn-primary" href={links.back}>Back</a>
            <h1>{ software.name }</h1>
            <div className="show-header">
                <div className="software-details">
                    <b>Editor : </b>
                    { editor.name }<br />
                    <b>Short description :</b>
                    { software.short_desc }
                    <br />
                    <div className="btn-group isolated" role="group">
                        <a className="btn btn-default btn-xs" href={links.edit_soft}>Edit</a>
                        <a className="btn btn-danger btn-xs"
                           data-method="delete" data-confirm="Are you sure?" rel="nofollow"
                           href={links.delete_soft}>Delete</a>
                    </div>
                </div>
            </div>

            <div className="right-column">
                <label className="control-label">Version : </label>
                <Software.VersionSelect versions={this.state.versions} onChange={this.changeVersion}/>
                <br />
                <a className="btn btn-large btn-primary isolated"
                   href={links.new_software_version}>New version</a>
            </div>
            <hr />

            <div className="version-header">
                <strong>{ software.name }</strong>
                Version {this.state.currentVersion}

                <div className="btn-group" role="group">
                    <a className="btn btn-default btn-xs" id="edit-version" href={links.edit_version}>Edit</a>
                    <a className="btn btn-danger btn-xs" id="destroy-version" href="#">Delete</a>
                </div>
            </div>

            <div>
                {/* Nav tabs */}
                <ul className="nav nav-tabs" role="tablist">
                    <li role="presentation"><a href="#details" aria-controls="details" aria-expanded="true" role="tab" data-toggle="tab">Details</a></li>
                    <li role="presentation"><a href="#presentation" aria-controls="presentation" role="tab" data-toggle="tab">Presentation</a></li>
                </ul>

                {/*  Tab panes */}
                <div className="tab-content" id="version-desc">
                    <div role="tabpanel" className="tab-pane fade active" id="details">
                        {/*
                        /!\
                        All fields in this area are filled with JQuery (AJAX)
                        See assets/javascript/softwares.coffee
                        */}
                        <div className="version-details bs-callout bs-callout-info">



                            <dl className="dl-horizontal">
                                <dt>OS</dt>
                                <dd>
                                    <div id="version-os-windows" className="os-icon"/>
                                    <div id="version-os-linux" className="os-icon"/>
                                    <div id="version-os-apple" className="os-icon"/>
                                </dd>

                                <dt>Release date</dt>
                                <dd>
                                    <div id="version-date"/>
                                </dd>

                                <dt>Distrilog</dt>
                                <dd>
                                    <div id="version-distrilog"/>
                                </dd>
                            </dl>

                            <div className="link-buttons">
                                <a href="#" target="_blank" id="dl-link" className="btn btn-sm btn-primary external-link">Download</a>
                                <a href="#" target="_blank" id="doc-link" className="btn btn-sm btn-primary external-link">Visit website</a>
                            </div>
                        </div>
                    </div>

                    <div role="tabpanel" className="tab-pane fade" id="presentation">
                        <h1>Presentation</h1>
                    </div>
                </div>

            </div>
        </div>;
    },
    changeVersion(newVal, oldVal) {
        this.setState({currentVersion: newVal});
    }
});


/*
 <%= select_tag :version, options_for_select(@versions.all.map{|v|[v.name, v.id]}),
 {class: "form-control",
 id: "select-version"} %>


 */
window.Software.VersionSelect = React.createClass({
    getInitialState () {
        return {
            value: undefined
        }
    },
    render: function() {
        var versionOptions = this.props.versions.map(
            version => <option key={version.id} value={version.id}>{version.name}</option>
        );
        return <select className="form-control" id="select-version">
            {versionOptions}
        </select>;
    },
    componentDidMount: function () {
        this.mySelect = $(ReactDOM.findDOMNode(this));
        this.mySelect
            .select2({theme: "bootstrap"})
            .on('change', this.onChange);
    },
    componentDidUpdate() {
        this.onChange();
    },
    onChange: function() {
        var newVal = this.mySelect.val();

        if (this.props.onChange) {
            this.props.onChange(newVal, this.oldValue);
        }
        this.oldValue = newVal;
    }

});
